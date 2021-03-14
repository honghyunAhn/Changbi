package forFaith.xml;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 * @Class Name : XMLDomParser.java
 * @Description : xml 파서
 * @Modification Information
 * @
 * @  수정일                 수정자                       수정내용
 * @ -------    --------    ---------------------------
 * @ 2017.03.21   김준석                      최초 생성
 *
 *  @author kjs
 *  @since 2017.03.21
 *  @version 1.0
 *  @see
 *
 */

public class XMLDomParser {

	private final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	private final DocumentBuilder builder = factory.newDocumentBuilder();
	private Document document;

	public XMLDomParser() throws ParserConfigurationException {
		factory.setIgnoringElementContentWhitespace(true);
	}

	public XMLDomParser(String uri) throws ParserConfigurationException, IOException, SAXException {
		this.document = this.builder.parse(uri);
		this.document.getDocumentElement().normalize();
	}

	public void setDocument(String uri) throws IOException, SAXException {
		this.document = this.builder.parse(uri);
		this.document.getDocumentElement().normalize();
	}

	public void setDocument(File f) throws IOException, SAXException {
		this.document = this.builder.parse(f);
		this.document.getDocumentElement().normalize();
	}

	public void setDocument(InputSource is) throws IOException, SAXException {
		this.document = this.builder.parse(is);
		this.document.getDocumentElement().normalize();
	}

	public void setDocument(InputStream is) throws IOException, SAXException {
		this.document = this.builder.parse(is);
		this.document.getDocumentElement().normalize();
	}

	public void setDocument(InputStream is, String systemId) throws IOException, SAXException {
		this.document = this.builder.parse(is, systemId);
		this.document.getDocumentElement().normalize();
	}

	public int getNodeCount() {
		return getNodeCount(this.document.getDocumentElement());
	}

	public int getNodeCount(String parentTagName) {
		return getNodeCount(getNode(parentTagName));
	}

	public int getNodeCount(Node parentNode) {
		NodeList nodeList = getChildNodeList(parentNode);
		return nodeList != null ? nodeList.getLength() : 0;
	}

	public String getNodeName(int item) {
		return getNodeName(this.document.getDocumentElement().getChildNodes(), item);
	}

	public String getNodeName(NodeList nodeList, int item) {
		return getNodeName(getNode(nodeList, item));
	}

	public String getNodeName(Node node) {
		return node != null ? node.getNodeName() : "";
	}

	public String getNodeValue(int item) {
		return getNodeValue(this.document.getDocumentElement().getChildNodes(), item);
	}

	public String getNodeValue(String tagName) {
		return getNodeValue(tagName, 0);
	}

	public String getNodeValue(String tagName, int item) {
		return getNodeValue(this.document.getElementsByTagName(tagName), item);
	}

	public String getNodeValue(NodeList nodeList, int item) {
		return getNodeValue(getNode(nodeList, item));
	}

	public String getNodeValue(NodeList nodeList, String tagName) {
		return getNodeValue(getNode(nodeList, tagName));
	}

	public String getNodeValue(Node node) {
		return node != null ? node.getTextContent() : "";
	}

	public NodeList getChildNodeList(String parentTagName) {
		return getChildNodeList(parentTagName,0);
	}

	public NodeList getChildNodeList(String parentTagName, int item) {
		return getChildNodeList(getNode(parentTagName, item));
	}

	public NodeList getChildNodeList(Node parentNode) {
		return parentNode != null ? parentNode.getChildNodes() : null;
	}

	public Node getNode(String tagName) {
		return getNode(tagName, 0);
	}

	public Node getNode(String tagName, int item) {
		NodeList nodeList = this.document.getElementsByTagName(tagName);
		return nodeList != null ? nodeList.item(item) : null;
	}

	public Node getNode(String parentTagName, String childTagName) {
		return getNode(parentTagName, childTagName, 0);
	}

	public Node getNode(String parentTagName, String childTagName, int item) {
		return getNode(getNode(parentTagName,0), childTagName, item);
	}

	public Node getNode(Node parentNode, String childTagName) {
		return getNode(parentNode, childTagName, 0);
	}

	public Node getNode(Node parentNode, String childTagName, int item) {
		return getNode(getChildNodeList(parentNode), childTagName, item);
	}

	public Node getNode(NodeList nodeList) {
		return getNode(nodeList,0);
	}

	public Node getNode(NodeList nodeList, int item) {
		return nodeList != null ? nodeList.item(item) : null;
	}

	public Node getNode(NodeList nodeList, String tagName) {
		return getNode(nodeList, tagName, 0);
	}

	public String getAttributeValue(Node node, String attributeName) {
		Node attrNode = node.getAttributes().getNamedItem(attributeName);
		return attrNode != null ? attrNode.getNodeValue() : "";
	}

	public Node getNode(NodeList nodeList, String tagName, int item) {
		Node node = null;
		int count = 0;
		int length = nodeList != null ? nodeList.getLength() : 0;

		for(int i=0; i<length; ++i) {
			node = nodeList.item(i);
			if(item == count++ && getNodeName(node).equals(tagName)) break;
		}

		return node;
	}
}