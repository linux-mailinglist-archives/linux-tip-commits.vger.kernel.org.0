Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA36BD21C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Mar 2023 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCPOOh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Mar 2023 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCPOOG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Mar 2023 10:14:06 -0400
Received: from mail.belitungtimurkab.go.id (unknown [103.205.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B404A908B;
        Thu, 16 Mar 2023 07:13:17 -0700 (PDT)
Received: from mail.belitungtimurkab.go.id (localhost.localdomain [127.0.0.1])
        by mail.belitungtimurkab.go.id (Postfix) with ESMTPS id 957E98A548C;
        Thu, 16 Mar 2023 18:17:09 +0700 (WIB)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.belitungtimurkab.go.id (Postfix) with ESMTP id 316998A56C9;
        Thu, 16 Mar 2023 17:11:03 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.belitungtimurkab.go.id 316998A56C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=belitungtimurkab.go.id; s=mail; t=1678961463;
        bh=LjBXUFVAwYLFBDK7H9dfJR2LVch/buu352HP+VChywc=;
        h=Date:From:Message-ID:MIME-Version;
        b=POUS/KWJftkutW85SCc8/ftKzecb0oagPNYLSKIYJrqGp7GDFw+IWNyZIk4knHn3H
         VNZNSC/SpJNJlKo149yRcM8l8zzrGVvtClDugpjEXSDEfISKW5Bj3zALkWNSJm1A+1
         EBXyq3Mvzf5HTAw2+i8722gGo85bdCAVxVQrP9JZAwRjDrM12sLHsIjewSXoh5DsP8
         O1haJLfmSJ6ruWVDGcTEYinIkLSJBj12UBZTKSCo7TuBach7tnIKxZW4tmT8dV++PJ
         O2yuMSY4TSgXopwYk4HG3ncLSKSyilWERiXcIIdMeJRY6gB0u6wZMhQd003tbpPzNb
         eNnzvz8UkhDzQ==
Received: from mail.belitungtimurkab.go.id ([127.0.0.1])
        by localhost (mail.belitungtimurkab.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zl7fotI3kTVn; Thu, 16 Mar 2023 17:11:02 +0700 (WIB)
Received: from mail.belitungtimurkab.go.id (mail.belitungtimurkab.go.id [103.205.56.27])
        by mail.belitungtimurkab.go.id (Postfix) with ESMTP id E3F108A523D;
        Thu, 16 Mar 2023 17:11:00 +0700 (WIB)
Date:   Thu, 16 Mar 2023 17:11:00 +0700 (WIB)
From:   =?utf-8?B?0KHQuNGB0YLQtdC80L3Ri9C5INCw0LTQvNC40L3QuNGB0YLRgNCw0YLQvtGA?= 
        <dinkes@belitungtimurkab.go.id>
Reply-To: sistemassadmins@mail2engineer.com
Message-ID: <181903034.71317.1678961460904.JavaMail.zimbra@belitungtimurkab.go.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [103.205.56.27]
X-Mailer: Zimbra 8.7.11_GA_3789 (zclient/8.7.11_GA_3789)
Thread-Index: /QAqzWPI4OG+FzD1PiB1yr991QqwnQ==
Thread-Topic: 
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        MISSING_HEADERS,RDNS_NONE,REPLYTO_WITHOUT_TO_CC,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  0.0 T_SPF_HELO_TEMPERROR SPF: test of HELO record failed
        *      (temperror)
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


=D0=92=D0=9D=D0=98=D0=9C=D0=90=D0=9D=D0=98=D0=95;

=D0=92=D0=B0=D1=88 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=
=D1=89=D0=B8=D0=BA =D0=BF=D1=80=D0=B5=D0=B2=D1=8B=D1=81=D0=B8=D0=BB =D0=BE=
=D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D0=BB=D0=B8=D1=89=D0=B0, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=
=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=B0=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=
 5 =D0=93=D0=91, =D0=BA=D0=B0=D0=BA =D0=BE=D0=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=
=BB=D0=B5=D0=BD=D0=BE =D0=B0=D0=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=
=80=D0=B0=D1=82=D0=BE=D1=80=D0=BE=D0=BC, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=
=8B=D0=B9 =D0=B2 =D0=BD=D0=B0=D1=81=D1=82=D0=BE=D1=8F=D1=89=D0=B5=D0=B5 =D0=
=B2=D1=80=D0=B5=D0=BC=D1=8F =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=B5=D1=
=82 =D0=BD=D0=B0 10,9 =D0=93=D0=91, =D0=B2=D1=8B =D0=BD=D0=B5 =D1=81=D0=BC=
=D0=BE=D0=B6=D0=B5=D1=82=D0=B5 =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=
=D1=8F=D1=82=D1=8C =D0=B8=D0=BB=D0=B8 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B0=
=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=83=D1=8E =D0=BF=D0=BE=D1=87=D1=82=D1=83=
 =D0=B4=D0=BE =D1=82=D0=B5=D1=85 =D0=BF=D0=BE=D1=80, =D0=BF=D0=BE=D0=BA=D0=
=B0 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D0=B5 =D0=
=BF=D0=BE=D1=87=D1=82=D1=83 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D0=BE=D0=
=B3=D0=BE =D1=8F=D1=89=D0=B8=D0=BA=D0=B0 =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=
=80=D0=BD=D0=BE. =D0=A7=D1=82=D0=BE=D0=B1=D1=8B =D0=BF=D0=BE=D0=B2=D1=82=D0=
=BE=D1=80=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=
=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=
=B9 =D1=8F=D1=89=D0=B8=D0=BA, =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D1=8C=D1=
=82=D0=B5 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D1=83=D1=8E =D0=B8=D0=
=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BD=D0=B8=D0=B6=D0=
=B5:

=D0=B8=D0=BC=D1=8F:
=D0=98=D0=BC=D1=8F =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8F:
=D0=BF=D0=B0=D1=80=D0=BE=D0=BB=D1=8C:
=D0=9F=D0=BE=D0=B4=D1=82=D0=B2=D0=B5=D1=80=D0=B4=D0=B8=D1=82=D0=B5 =D0=BF=
=D0=B0=D1=80=D0=BE=D0=BB=D1=8C:
=D0=AD=D0=BB=D0=B5=D0=BA=D1=82=D1=80=D0=BE=D0=BD=D0=BD=D0=B0=D1=8F =D0=BF=
=D0=BE=D1=87=D1=82=D0=B0:
=D0=A2=D0=B5=D0=BB=D0=B5=D1=84=D0=BE=D0=BD:

=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=
=D1=82=D0=B5 =D0=BF=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=BD=D0=BE =D0=BF=D1=80=
=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D1=81=D0=B2=D0=BE=D0=B9 =D0=BF=
=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=D1=89=D0=B8=D0=BA, =D0=B2=
=D0=B0=D1=88 =D0=BF=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D1=8B=D0=B9 =D1=8F=D1=89=
=D0=B8=D0=BA =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BE=D1=82=D0=BA=D0=BB=D1=8E=
=D1=87=D0=B5=D0=BD!

=D0=9F=D1=80=D0=B8=D0=BD=D0=BE=D1=81=D0=B8=D0=BC =D0=B8=D0=B7=D0=B2=D0=B8=
=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0 =D0=BD=D0=B5=D1=83=D0=B4=D0=BE=
=D0=B1=D1=81=D1=82=D0=B2=D0=B0.
=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BE=D1=87=D0=BD=D1=8B=D0=B9 =D0=BA=
=D0=BE=D0=B4: en: WEB. =D0=90=D0=94=D0=9C=D0=98=D0=9D=D0=98=D0=A1=D0=A2=D0=
=A0=D0=90=D0=A2=D0=9E=D0=A0=D0=90. RU006,524765 @2023
=D0=9F=D0=BE=D1=87=D1=82=D0=BE=D0=B2=D0=B0=D1=8F =D1=82=D0=B5=D1=85=D0=BD=
=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=8F =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=
=D1=80=D0=B6=D0=BA=D0=B0 @2023

=D0=A1=D0=BF=D0=B0=D1=81=D0=B8=D0=B1=D0=BE
=D0=A1=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D1=8B=D0=B9 =D0=B0=D0=B4=D0=BC=
=D0=B8=D0=BD=D0=B8=D1=81=D1=82=D1=80=D0=B0=D1=82=D0=BE=D1=80.
