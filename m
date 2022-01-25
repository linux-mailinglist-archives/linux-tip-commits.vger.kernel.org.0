Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66E49B7AF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jan 2022 16:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357652AbiAYPet (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 Jan 2022 10:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353755AbiAYPck (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 Jan 2022 10:32:40 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B2AC06175B
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Jan 2022 07:20:46 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id e79so24030802iof.13
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Jan 2022 07:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IEMma1eGW5sQblzU1//BqOEn5E488+F+nzzq2q8j3TU=;
        b=Ax85Rof6PBMBG+MGZzS0xiFN8n2vWSwUEcvoUa97lsR5/qokCV8HhkYfy+vXhRnPBX
         LlEiIHnhXKYWNOMqyqgCHLJucHNCl8fpS9B7fV+rUmZetY6rz63+U5LJIMtdKCY71oKG
         jKea6rI+oDY0PWphiDlK3bFvhw69wUhxbgoSnQrHwXV3xOD9oZPU6CaOxsuuO15fY9Vn
         xZp82q6HTq2mu4e9ek0L2tJsFfjbsut6IqFoWhIgl+lY7eyiM8iRJIf1PRb7ZMkxGYoM
         U74URDDvnKFjOZvzW7nwPQ8qYNySJsvtGFNUrcFYxJyJKX/So4oy56qEITZ9dPvK6faH
         2EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=IEMma1eGW5sQblzU1//BqOEn5E488+F+nzzq2q8j3TU=;
        b=MSb77QhiYiOSXaZcbHE2HUG8pFh07/M6vdtqg7fPh0/QJ9qprSdu7/zkBrfH7RWZgz
         DbWpby4IW95StEnqrDLU5Q8wDup06SY+dgzDp289If8GagYLCnrrv9069cvODYF6Ahuk
         5Ge5XHYEh0xre0pZGJ6LyYsXZL0j+V5kMHhtEN6NEhXX+7wl1NtpEZO/t1SN1STgFLbK
         PHHTlWfw4Jkcli8MRKeFy5Aw/EBJC1x4OmVrv6oF1yHLXJBXeFYZJeGYI9vTL24Q+0mw
         5oZc/IkhcXStM3a2+Zj1L/+4dsJAwSVuyg+dNCSscLy0cxudBxGkQYxkuaX+FnyA8q9I
         c1aQ==
X-Gm-Message-State: AOAM530IhNqS/BVPWrVLwCJdKU0i7sWuaKNdDtE51QpuDIDclU/9C/d5
        Z7IXlqwXrR8M3TBdKxzb7CqvJSsyvRgxf4p0KNc=
X-Google-Smtp-Source: ABdhPJyOANnTMNkPnzQdJ7/VlcaN8SMh5oyOhqCSYzNcTJ/da2yiQ+3biKj36bhUI65nK+cp5oMSoSY6+0CXLQ9usCM=
X-Received: by 2002:a02:cd1c:: with SMTP id g28mr4262141jaq.189.1643124045564;
 Tue, 25 Jan 2022 07:20:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1566:0:0:0:0 with HTTP; Tue, 25 Jan 2022 07:20:45
 -0800 (PST)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <awochambers004@gmail.com>
Date:   Tue, 25 Jan 2022 07:20:45 -0800
Message-ID: <CAH2diS5sKKLres7iCGdCiSRqEKW=-m0zp0Jw=Oe0X4DWq=dsHw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Prosz=C4=99 o uwag=C4=99,

Jak si=C4=99 masz? Mam nadziej=C4=99, =C5=BCe jeste=C5=9B zdrowy i zdrowy? =
Informuj=C4=99, =C5=BCe
uda=C5=82o mi si=C4=99 zako=C5=84czy=C4=87 transakcj=C4=99 z pomoc=C4=85 no=
wego partnera z Indii i
teraz =C5=9Brodki zosta=C5=82y przelane do Indii na konto bankowe nowego
partnera.

W mi=C4=99dzyczasie zdecydowa=C5=82em si=C4=99 zrekompensowa=C4=87 ci sum=
=C4=99 500 000 $
(tylko pi=C4=99=C4=87set tysi=C4=99cy dolar=C3=B3w ameryka=C5=84skich) z po=
wodu twoich
wcze=C5=9Bniejszych wysi=C5=82k=C3=B3w, chocia=C5=BC mnie rozczarowa=C5=82e=
=C5=9B. Niemniej jednak
bardzo si=C4=99 ciesz=C4=99 z pomy=C5=9Blnego zako=C5=84czenia transakcji b=
ez =C5=BCadnego
problemu i dlatego postanowi=C5=82em zrekompensowa=C4=87 Ci kwot=C4=99 500 =
000 $,
aby=C5=9B podzieli=C5=82 si=C4=99 ze mn=C4=85 rado=C5=9Bci=C4=85.

Radz=C4=99 skontaktowa=C4=87 si=C4=99 z moj=C4=85 sekretark=C4=85 w sprawie=
 karty bankomatowej
o warto=C5=9Bci 500 000 $, kt=C3=B3r=C4=85 zachowa=C5=82em dla Ciebie. Skon=
taktuj si=C4=99 z
ni=C4=85 teraz bez zw=C5=82oki.

Imi=C4=99: Linda Koffi
E-mail: koffilinda785@gmail.com


Uprzejmie potwierd=C5=BA jej nast=C4=99puj=C4=85ce informacje:

Twoje pe=C5=82ne imi=C4=99:........
Tw=C3=B3j adres:..........
Tw=C3=B3j kraj:..........
Tw=C3=B3j wiek:.........
Tw=C3=B3j zaw=C3=B3d:..........
Tw=C3=B3j numer telefonu kom=C3=B3rkowego:..........
Tw=C3=B3j paszport lub prawo jazdy:........

Pami=C4=99taj, =C5=BCe je=C5=9Bli nie prze=C5=9Blesz jej powy=C5=BCszych in=
formacji
kompletnych, nie wyda ci karty bankomatowej, poniewa=C5=BC musi si=C4=99
upewni=C4=87, =C5=BCe to ty. Popro=C5=9B j=C4=85, aby przes=C5=82a=C5=82a C=
i ca=C5=82kowit=C4=85 sum=C4=99 (500 000
USD) karty bankomatowej, kt=C3=B3r=C4=85 dla Ciebie zachowa=C5=82em.

Z wyrazami szacunku,

Pan Abraham Morrison
