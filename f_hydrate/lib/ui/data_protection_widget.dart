import 'package:f_hydrate/ui/drawer.dart';
import 'package:f_hydrate/ui/theme_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * Stateful Widget zur Anzeige der Datenschutzbestimmungen.
 */
class DataProtectionWidget extends StatefulWidget {
  const DataProtectionWidget({Key? key}) : super(key: key);

  final String title = "Datenschutz";

  @override
  DataProtectionState createState() => DataProtectionState();
}

class DataProtectionState extends State<DataProtectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBuilder.build(context),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: createBody(context),
    );
  }

  dynamic createBody(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(20.0),
      child: SelectableText.rich(
        TextSpan(
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1!.color ??
                  Colors.black,
              fontSize: 15),
          children: <TextSpan>[
            TextSpan(text: '''
1. Name und Anschrift des Verantwortlichen
Allgemeine Anschrift:

Prof. Dr. Dino Schönberg
Sonnenstraße 96
44139 Dortmund 
Tel. +49 (0)231 9112-0
Fax +49 (0)231 9112-313

Postanschrift:
Fachhochschule Dortmund
Postfach 10 50 18
44047 Dortmund
Aufsichtsbehörde:
Ministerium für Kultur und Wissenschaft des Landes Nordrhein-Westfalen (MKW NRW)

2. Datenschutzbeauftragte der Fachhochschule Dortmund
Für weitere Fragen und Auskünfte rund um das Thema Datenschutz stehen Ihnen die Datenschutzbeauftragten der Fachhochschule Dortmund zur Verfügung. Bitte wenden Sie sich an die Datenschutzbeauftragten:Dr. Thilo Groll und Katrin Zeigerer
E-Mail: datenschutz@fh-dortmund.de

3. Allgemeines zur Datenverarbeitung
Wir erheben und verwenden personenbezogene Daten unserer Nutzer grundsätzlich nur, soweit dies zur Bereitstellung einer funktionsfähigen Website sowie unserer Inhalte und Leistungen erforderlich ist und eine Rechtsgrundlage uns dies gestattet.

Rechtsgrundlage für die Verarbeitung personenbezogener Daten
Soweit wir für Verarbeitungsvorgänge personenbezogener Daten eine Einwilligung der betroffenen Person einholen, dient Art. 6 Abs. 1 lit. a DSGVO als Rechtsgrundlage für die Verarbeitung personenbezogener Daten. 
Soweit eine Verarbeitung personenbezogener Daten zur Erfüllung einer rechtlichen Verpflichtung erforderlich ist, der die Fachhochschule Dortmund unterliegt, dient Art. 6 Abs. 1 lit. c DSGVO als Rechtsgrundlage.
Für den Fall, dass lebenswichtige Interessen der betroffenen Person oder einer anderen natürlichen Person eine Verarbeitung personenbezogener Daten erforderlich machen, dient Art. 6 Abs. 1 lit. d DSGVO als Rechtsgrundlage.
Ist die Verarbeitung für die Wahrnehmung einer Aufgabe erforderlich, die im öffentlichen Interesse liegt oder in Ausübung öffentlicher Gewalt erfolgt, die der Fachhochschule Dortmund übertragen wurde, so dient Art. 6 Abs. 1 lit. e DSGVO als Rechtsgrundlage für die Verarbeitung. Ist die Verarbeitung zur Wahrung eines berechtigten Interesses der Fachhochschule Dortmund oder eines Dritten erforderlich und überwiegen die Interessen, Grundrechte und Grundfreiheiten des Betroffenen das erstgenannte Interesse nicht, so dient Art. 6 Abs. 1 lit. f DSGVO als Rechtsgrundlage für die Verarbeitung. Dies gilt nicht, soweit die Fachhochschule Dortmund bei der entsprechenden Verarbeitung hoheitlich tätig wird.

Dauer der Speicherung personenbezogener Daten
Die personenbezogenen Daten des Betroffenen werden von uns nur solange gespeichert, wie der Zweck der Speicherung besteht. Wenn die Verarbeitung auf einer Einwilligung des Betroffenen beruht, werden die Daten nur solange gespeichert, bis der Betroffene seine Einwilligung widerruft, es sei denn, es besteht eine andere Rechtsgrundlage für die Verarbeitung.

Recht auf Berichtigung und Löschung der personenbezogenen Daten
Der Betroffene hat das Recht, von uns unverzüglich die Berichtigung ihn betreffender unrichtiger personenbezogener Daten zu verlangen. Der Betroffene hat außerdem das Recht, von uns unverzüglich die Löschung ihn betreffender personenbezogener Daten zu verlangen, sobald der Zweck der Speicherung entfällt oder, wenn die Verarbeitung auf einer Einwilligung des Betroffenen beruht, wenn der Betroffene seine Einwilligung widerruft und keine andere Rechtsgrundlage für die Verarbeitung besteht.
Die personenbezogenen Daten des Betroffenen werden weiterhin gelöscht, wenn er gem. Art. 21 Abs. 1 DSGVO Widerspruch gegen die Verarbeitung einlegt und keine vorrangigen berechtigten Gründe für die Verarbeitung vorliegen, wenn die personenbezogenen Daten unrechtmäßig verarbeitet wurden oder wenn die Löschung zur Erfüllung einer rechtlichen Verpflichtung durch den europäischen oder nationalen Gesetzgeber in Vorschriften, denen die Fachhochschule Dortmund unterliegt, vorgesehen wurde.
Eine Löschung erfolgt jedoch in den oben dargestellten Fällen nicht, wenn die Verarbeitung der personenbezogenen Daten erforderlich ist, damit die Fachhochschule Dortmund eine rechtliche Verpflichtung, die ihr durch den europäischen oder nationalen Gesetzgeber auferlegt wurde, erfüllen kann oder wenn die Verarbeitung zur Wahrnehmung einer Aufgabe der Fachhochschule Dortmund erfolgt, die im öffentlichen Interessen liegt oder in Ausübung öffentlicher Gewalt erfolgt, die der Fachhochschule Dortmund übertragen wurde oder wenn die weitere Speicherung der personenbezogenen Daten zur Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen erforderlich ist.

Recht auf Widerruf
Beruht die Verarbeitung personenbezogener Daten auf einer Einwilligung der betroffenen Person, so kann diese ihre Einwilligung jederzeit widerrufen. Die bis zum Widerruf erfolgte Verarbeitung personenbezogener Daten bleibt trotz des Widerrufs rechtmäßig.

Recht auf Auskunft
Die betroffene Person hat das Recht, von der Fachhochschule Dortmund eine Bestätigung darüber zu verlangen, ob sie betreffende personenbezogene Daten verarbeitet werden. Wenn dies der Fall ist, hat die betroffene Person ein Recht auf Auskunft, um welche personenbezogenen Daten es sich handelt und für welche Zwecke diese verarbeitet werden. Sie hat außerdem ein Recht auf Auskunft über die Dauer der geplanten Speicherung dieser Daten bzw. welche Kriterien für die Festlegung der Speicherdauer angewendet werden.

4. Statistische Erhebung, Matomo
Umfang der Datenverarbeitung
Wir nutzen auf unserer Website das Open-Source-Software-Tool Matomo (ehemals PIWIK) zur Analyse des Surfverhaltens unserer Nutzer*innen. Werden Einzelseiten unserer Website aufgerufen, so werden folgende Daten gespeichert:
- zwei Bytes der IP-Adresse des aufrufenden Systems der Nutzer*innen
- die aufgerufene Webseite
- Informationen über den Browsertyp und die verwendete Version
- das Betriebssystem der Nutzer*innen
- die Webseite, von der die Nutzer*innen auf die aufgerufene Webseite gelangt sind (Referrer)
- Datum und Uhrzeit des Zugriffs
- die Unterseiten, die von der aufgerufenen Webseite aus aufgerufen werden
- die Verweildauer auf der Webseite
- die Häufigkeit des Aufrufs der Webseite
- Websites, die vom System der Nutzer*innen über unsere Website aufgerufen werden
Die Software läuft dabei ausschließlich auf den Servern unserer Webseite. Eine Speicherung der personenbezogenen Daten der Nutzer findet nur dort statt. Eine Weitergabe der Daten an Dritte erfolgt nicht.

Auf dieser Website werden mithilfe des Webtrackingtools Matomo Daten zu statistischen und Optimierungszwecken gesammelt und gespeichert. Zu diesem Zweck werden erzeugten Nutzungsinformationen (einschließlich Ihrer anonymisierten IP-Adresse) an unseren Server übertragen und gespeichert. Diese Funktion lässt sich im Abschnitt "Matomo Opt-Out" deaktivieren.
Die erzeugten Informationen werden ausschließlich für statistische Zwecke und zur Verbesserung des Internetauftritts und Servers genutzt. Ihre IP-Adresse wird anonymisiert und kann nicht auf Sie zurückgeführt werden. Eine Weitergabe an Dritte findet nicht statt.
Die Software ist so eingestellt, dass die IP-Adressen nicht vollständig gespeichert werden, sondern zwei Bytes der IP-Adresse maskiert werden. Auf diese Weise ist eine Zuordnung der gekürzten IP-Adresse zum aufrufenden Rechner nicht mehr möglich.
Beim Abruf einer Webseite werden Daten über diesen Vorgang gespeichert. Im Einzelnen sind dies die folgenden Informationen: Seitentitel, Suchbegriff (durch die Besucher auf die Seite kommen), Suchmaschinen, Seiten-URL, Anzahl der besuchten Seiten, Standort des Besuchers (Land), Provider, Browser, Betriebssystem, Bildschirmauflösung, Browserplugins, Besuchszeiten, Besuchsdauer, Eingangsseiten, Ausstiegsseiten, Downloads, verweisende Webseiten.

4.1 Widerspruch gegen Datenspeicherung
Als Nutzer*in haben Sie jederzeit die Möglichkeit, das Tracking durch Matomo abzulehnen. (Abschnitt "Matomo Opt-Out")
Wenn Nutzer*innen in ihrem Browser eine Option "Ich möchte nicht getrackt werden" aktiviert haben, dann werden von ihnen keine Daten durch Matomo gespeichert.
Achtung: Wenn Sie Ihre Cookies löschen, so hat dies zur Folge, dass auch das Opt-Out-Cookie gelöscht wird und ggf. von Ihnen erneut aktiviert werden muss.

4.2 Rechtgrundlage für die Verarbeitung
Rechtsgrundlage für die Verarbeitung der personenbezogenen Daten der Nutzer ist Art. 6 Abs. 1 lit. f DSGVO.

4.3 Zweck der Verarbeitung
Die Verarbeitung der personenbezogenen Daten der Nutzer ermöglicht uns eine Analyse des Surfverhaltens unserer Nutzer. Wir sind durch die Auswertung der gewonnenen Daten in der Lage, Informationen über die Nutzung der einzelnen Komponenten unserer Webseite zusammenzustellen. Dies hilft uns dabei, unsere Webseite und deren Nutzerfreundlichkeit stetig zu verbessern.

4.4 Dauer der Speicherung der personenbezogenen Daten
Die Daten werden gelöscht, sobald sie für unsere Aufzeichnungszwecke nicht mehr benötigt werden. Cookies werden auf dem Rechner des Nutzers gespeichert und von diesem an unsere Seite übermittelt. Daher haben Sie als Nutzer auch die volle Kontrolle über die Verwendung von Cookies. Durch eine Änderung der Einstellungen in Ihrem Internetbrowser können Sie die Übertragung von Cookies deaktivieren oder einschränken. Bereits gespeicherte Cookies können jederzeit gelöscht werden. Dies kann auch automatisiert erfolgen. Werden Cookies für unsere Website deaktiviert, können möglicherweise nicht mehr alle Funktionen der Website vollumfänglich genutzt werden.

5. Nutzer*innenrechte
Sie haben das Recht, Auskunft über Art und Umfang der mit Ihrem Besuch auf der Internetseite verbundenen Speicherung zu erhalten. Weiterhin stehen Ihnen die Rechte auf Widerspruch gegen die Verarbeitung, Berichtigung, Datenübertragung, Löschung und Einschränkung der Verarbeitung zu. Bitte wenden Sie sich dazu an den Datenschutzbeauftragten der Fachhochschule Dortmund.

________________________________________________________

Haftungsausschluss

1. Inhalt des Online-Angebotes 
Die Fachhochschule Dortmund übernimmt keinerlei Gewähr für die Aktualität, Korrektheit, Vollständigkeit oder Qualität der bereitgestellten Informationen. Haftungsansprüche gegen die Fachhochschule Dortmund, welche sich auf Schäden materieller oder ideeller Art beziehen, die durch die Nutzung der dargebotenen Informationen bzw. durch die Nutzung fehlerhafter und unvollständiger Informationen verursacht wurden, sind grundsätzlich ausgeschlossen, sofern seitens der Fachhochschule Dortmund kein nachweislich vorsätzliches oder grob fahrlässiges Verschulden vorliegt.

2. Verweise und Links
Bei direkten oder indirekten Verweisen auf fremde Internetseiten ("Links"), die außerhalb des Verantwortungsbereiches der Fachhochschule Dortmund liegen, würde eine Haftungsverpflichtung ausschließlich in dem Fall in Kraft treten, in dem die Fachhochschule Dortmund von den Inhalten Kenntnis hat und es ihr technisch möglich und zumutbar wäre, die Nutzung im Falle rechtswidriger Inhalte zu verhindern. Die Fachhochschule Dortmund erklärt hiermit ausdrücklich, dass zum Zeitpunkt der Linksetzung keine illegalen Inhalte auf den zu verlinkenden Seiten erkennbar waren. Auf die aktuelle und zukünftige Gestaltung, die Inhalte oder die Urheberschaft der verlinkten/verknüpften Seiten hat die Fachhochschule Dortmund keinerlei Einfluss. Deshalb distanziert sie sich hiermit ausdrücklich von allen Inhalten aller verlinkten/verknüpften Seiten, die nach der Linksetzung verändert wurden. Diese Feststellung gilt für alle innerhalb des eigenen Internetangebotes gesetzten Links und Verweise sowie für Fremdeinträge in von der Fachhochschule Dortmund eingerichteten Gästebüchern, Diskussionsforen, Linkverzeichnissen, Mailinglisten und allen anderen Formen von Datenbanken, auf deren Inhalt externe Schreibzugriffe möglich sind. Falls von der Fachhochschule Dortmund auf Seiten verwiesen wird, deren Inhalt Anlass zu Beanstandungen gibt, besteht jederzeit die Möglichkeit einer entsprechenden Mitteilung an die Webmaster. Für weiterführende Hyperlinks, die nicht durch die Fachhochschule Dortmund, sondern durch verlinkte Drittanbieter gesetzt werden, übernimmt die Fachhochschule Dortmund keine Haftung. Für illegale, fehlerhafte oder unvollständige Inhalte und insbesondere für Schäden, die aus der Nutzung solcherart dargebotener Informationen entstehen, haftet allein der Anbieter der Seite, auf welche verwiesen wurde, nicht derjenige, der über Links auf die jeweilige Veröffentlichung lediglich verweist.

3. Urheber- und Kennzeichenrecht
Die Fachhochschule Dortmund ist bestrebt, in allen Publikationen die Urheberrechte der verwendeten Bild- und Tondokumente, Videosequenzen und Texte zu beachten, von ihr selbst erstellte Bild- und Tondokumente, Videosequenzen und Texte zu nutzen oder auf lizenzfreie Bild- und Tondokumente Videosequenzen und Texte zurückzugreifen. Alle innerhalb des Internetangebotes genannten und ggf. durch Dritte geschützten Marken- und Warenzeichen unterliegen uneingeschränkt den Bestimmungen des jeweils gültigen Kennzeichenrechts und den Besitzrechten der jeweiligen eingetragenen Inhaber. Auch Markenzeichen, die nicht entsprechend gekennzeichnet sind, können durch Rechte Dritter geschützt sein. Das Copyright für veröffentlichte, von der Fachhochschule Dortmund selbst erstellte Objekte bleibt allein bei der Fachhochschule Dortmund. Eine Vervielfältigung oder Verwendung solcher Bild- und Tondokumente, Videosequenzen und Texte in anderen elektronischen oder gedruckten Publikationen ist ohne ausdrückliche Zustimmung der Fachhochschule Dortmund nicht gestattet.4. Rechtswirksamkeit dieses Haftungsausschlusses
Dieser Haftungsausschluss ist als Teil des Internetangebotes zu betrachten, von dem aus auf diese Seite verwiesen wurde. Sofern Teile oder einzelne Formulierungen dieses Textes der geltenden Rechtslage nicht, nicht mehr oder nicht vollständig entsprechen sollten, bleiben die übrigen Teile des Dokumentes in ihrem Inhalt und ihrer Gültigkeit davon unberührt.          
          
          '''),
          ],
        ),
      ),
    ));
  }
}
