Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EBD45F320
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhKZRpp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 12:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhKZRno (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 12:43:44 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B6C0619D9
        for <linux-tip-commits@vger.kernel.org>; Fri, 26 Nov 2021 09:19:54 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id t23so20021788oiw.3
        for <linux-tip-commits@vger.kernel.org>; Fri, 26 Nov 2021 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=F8mAaNfSp1B2qpckgrUmaGov90eY6709B/lnYmhCEIU=;
        b=Mc8N4qphMGEEwPKvKvmwaTJffvaDG2OqIipclLqvqjz0IEhASfTy6CKiWB7ef6nLHo
         tZFNBm4hDc4X2GdhPLhcXnmXU0AYcncV9LrEjSKZqn8veeL9GGwngv20v7ta9whPfJ1d
         AW/Zd+PJM9tNJFCsntBsw4PYuJ5W4DbNinotpBSmPpw1or5PgFgySKYxNCpGSGN0kp/b
         5k/w3a+hhho9gszg1KM2I2j9G5uGFx/4F41PPaSOJeFEJ2KG+zxpZ23pA9otfh84xZnb
         tTacgcc4vWoms0zvhxjdjMBsMyGA1UoweumCtI9hJGu1Kdbg55+B+7x5xVj+7VXzn/yU
         7lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=F8mAaNfSp1B2qpckgrUmaGov90eY6709B/lnYmhCEIU=;
        b=xguTarKpGlpp8dHR9ak5+OO21a7nkfYlZbjnJ93LuqFQDjkF+C0JFBlUtxdF9+sDMa
         ch/sAJFVDdcrNFEuZFFkMh7Yyy/WnjKiTkV0gZlEsyb0Ig/u5tu0nHVWUPM7gC0otKfj
         ub2odZT5nqblYdPyKTCtsYfhn7yWltJRSQBybGZZXEmfWLEVYEQtePZCx8fpSV78rPx/
         Iv6icbkI1375r+TOSWBE56Veuhj+QTpEn4N+qGuTt/Pd1Z8QRrRBa3sXiT3bE6y0vPgW
         zVlbwr8MCREp2PVidmD5YLidMmoYjNKYTtCUyvzkmgWIO8MlguccagBQaWZOOjVC6tR1
         pNvA==
X-Gm-Message-State: AOAM531SDsKRNeH/N600sOEJBivIeyJKKSiP7Flt2VJc8kX1TEVhNjAb
        NCD0YYg3DXH4FvgqUSKY7dP8VkNYldmIJZmGtoQ=
X-Google-Smtp-Source: ABdhPJz6/IDBY7oTVTYAPjqu72SIczRZbzlo2p14ATn/1/tNN3i+GyanzI/p3V7Ld3WC+D6qxGlBXNvEm08IbyqMKfA=
X-Received: by 2002:a05:6808:c7:: with SMTP id t7mr24583411oic.30.1637947193466;
 Fri, 26 Nov 2021 09:19:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:65cd:0:0:0:0:0 with HTTP; Fri, 26 Nov 2021 09:19:53
 -0800 (PST)
Reply-To: msbelinaya892@gmail.com
From:   msbelinaya <philipsteler0@gmail.com>
Date:   Fri, 26 Nov 2021 17:19:53 +0000
Message-ID: <CAKCDfUjO0mGZy7oPdX9G4fNT_0dQp0Poa=_VXLOmSkmHmBufDg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Ich biete meine Freundschaft an und glaube, dass Sie mich mit einem
guten Herzen annehmen werden. Ich wurde gedr=C3=A4ngt, Sie zu kontaktieren
und zu sehen, wie wir uns am besten unterst=C3=BCtzen k=C3=B6nnen. Ich bin =
Frau
Kodjovi Hegbor aus der T=C3=BCrkei und arbeite als Operations Division
Manager bei der StandardBNP bank limited Turkey. Ich glaube, es ist
Gottes Wille, dass ich Sie jetzt treffen werde. Ich habe ein wichtiges
gesch=C3=A4ftliches Gespr=C3=A4ch, das ich mit Ihnen teilen m=C3=B6chte, vo=
n dem ich
glaube, dass es Sie interessiert, da es mit Ihrem Nachnamen
zusammenh=C3=A4ngt und Sie davon profitieren wird.

 Im Jahr 2006 er=C3=B6ffnete ein B=C3=BCrger Ihres Landes bei meiner Bank e=
in
36-monatiges Nicht-Residentenkonto im Wert von =C2=A3 8.400.000,00. Das
Ablaufdatum f=C3=BCr diese Hinterlegungsvereinbarung war der 16. Januar
2009. Leider starb er am 12. Mai 2008 in Sichuan, China, bei einem
t=C3=B6dlichen Erdbeben, bei dem auf einer Gesch=C3=A4ftsreise mindestens 6=
8.000
Menschen ums Leben kamen.

Die Gesch=C3=A4ftsleitung meiner Bank hat noch nichts von seinem Tod
geh=C3=B6rt, ich wusste davon, weil er mein Freund war und ich sein
Kontoverwalter war, als das Konto vor meiner Bef=C3=B6rderung er=C3=B6ffnet
wurde. Aber Herr
bei der Kontoer=C3=B6ffnung keine n=C3=A4chsten Verwandten/Erben erw=C3=A4h=
nt hat und
er nicht verheiratet war oder keine Kinder hatte. Letzte Woche bat
mich meine Bankdirektion, Anweisungen zu geben, was mit seinem Geld zu
tun sei, wenn der Vertrag verl=C3=A4ngert werden sollte.

Ich wei=C3=9F, dass dies passieren wird, und deshalb habe ich nach einem
Mittel gesucht, um mit der Situation umzugehen, denn wenn meine
Bankdirektoren wissen, dass sie tot sind und keinen Erben haben,
nehmen sie das Geld f=C3=BCr ihren pers=C3=B6nlichen Gebrauch, also tue ich=
 es
nicht Ich m=C3=B6chte nicht, dass so etwas passiert. Da habe ich deinen
Nachnamen gesehen, habe mich gefreut und suche nun deine Mitarbeit, um
dich als n=C3=A4chsten Verwandten/Erben des Kontos zu pr=C3=A4sentieren, da=
 du
den gleichen Nachnamen wie er hast und meine Bankzentrale das Konto
freigeben wird f=C3=BCr dich. Es besteht kein Risiko; die Transaktion
erfolgt im Rahmen einer legitimen Vereinbarung, die Sie vor
Rechtsverletzungen sch=C3=BCtzt.

Es ist besser f=C3=BCr uns, das Geld zu beanspruchen, als es den
Bankdirektoren zu =C3=BCberlassen, sie sind bereits reich. Ich bin kein
gieriger Mensch, also schlage ich vor, dass wir das Geld gleichm=C3=A4=C3=
=9Fig
aufteilen, 50/50% auf beide Parteien. Mein Anteil wird mir helfen,
mein eigenes Unternehmen zu gr=C3=BCnden und den Erl=C3=B6s f=C3=BCr wohlt=
=C3=A4tige
Zwecke zu verwenden, was mein Traum war.

Bitte teilen Sie mir Ihre Meinung zu meinem Vorschlag mit, ich brauche
wirklich Ihre Hilfe bei dieser Transaktion. Ich habe dich auserw=C3=A4hlt,
mir zu helfen, nicht durch mein eigenes Tun, meine Liebe, sondern bei
Gott, ich wollte, dass du wei=C3=9Ft, dass ich mir die Zeit genommen habe,
f=C3=BCr diese Nachricht zu beten, bevor ich dich jemals kontaktiert habe,
um deine Meinung mitzuteilen und bitte zu behandeln diese
Informationen als STRENG GEHEIM. Nach Erhalt Ihrer Antwort
ausschlie=C3=9Flich =C3=BCber meine pers=C3=B6nliche E-Mail-Adresse
msbelinaya892@gmail.com
gibt Ihnen Details zur Transaktion. Und eine Kopie der
Einlagenbescheinigung des Fonds und der Gr=C3=BCndungsurkunde der
Gesellschaft, die den Fonds gegr=C3=BCndet hat.
Gott segne in Erwartung Ihrer dringenden Antwort
Mit freundlichen Gr=C3=BC=C3=9Fen
Frau Kodjovi Hegbor
msbelinaya892@gmail.com
