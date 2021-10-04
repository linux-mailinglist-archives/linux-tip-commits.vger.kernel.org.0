Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B14208AD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhJDJug (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 05:50:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhJDJug (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 05:50:36 -0400
Date:   Mon, 04 Oct 2021 09:48:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633340926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bhf0bosuajGeJM66trQSiMiHK9yZQyVremleD+h3vM=;
        b=HSzuhsZSfwFmdqBbucuDh2LleaEEP+zhfECSd7ta0PcrMZzukPtDip5T5md7yxeWbYPW1Y
        waFARSG8MtYwj5fmKIcp+8la1Kp1Ch9jtKdAfQ+wxRR1YVe5N1h5bpc7o0Fppz4yYoefho
        lFCiig+jiEp72AnViJYqPhFuHJyO7S69bvQcYgvekhud0DfJb9hfzgA3sDfz7ia9WUvibu
        cRLESJ+VAI/41fmyWVitJ87dhFiztZqIRaORKGSvPtemWEkdCWBmoFQxZ1kKuEtYyW6av7
        Uod2G6v/aEsszRTBLN4gTm0U/Um9msn/0E7wgdK75oNscjhLWBy8j46T3pw88w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633340926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bhf0bosuajGeJM66trQSiMiHK9yZQyVremleD+h3vM=;
        b=Y6h7JVstzqrAGGFbrjmne21i8sT+gspmwJuE4LSCAcXFp4KFO+bEwqCE0rYKQdL+HKBsho
        8K4SODEJWfSWM/Dg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/Kconfig: Fix an unused variable error in dell-smm-hwmon
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Guenter Roeck <linux@roeck-us.net>, pali@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210910071921.16777-1-rdunlap@infradead.org>
References: <20210910071921.16777-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <163334092560.25758.6789545756076554393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     ef775a0e36c6a81c5b07cb228c02f967133fe768
Gitweb:        https://git.kernel.org/tip/ef775a0e36c6a81c5b07cb228c02f967133=
fe768
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 10 Sep 2021 00:19:21 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 11:11:48 +02:00

x86/Kconfig: Fix an unused variable error in dell-smm-hwmon

When CONFIG_PROC_FS is not set, there is a build warning (turned
into an error):

  ../drivers/hwmon/dell-smm-hwmon.c: In function 'i8k_init_procfs':
  ../drivers/hwmon/dell-smm-hwmon.c:624:24: error: unused variable 'data' [-W=
error=3Dunused-variable]
    struct dell_smm_data *data =3D dev_get_drvdata(dev);

Make I8K depend on PROC_FS and HWMON (instead of selecting HWMON -- it
is strongly preferred to not select entire subsystems).

Build tested in all possible combinations of SENSORS_DELL_SMM, I8K, and
PROC_FS.

Fixes: 039ae58503f3 ("hwmon: Allow to compile dell-smm-hwmon driver without /=
proc/i8k")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Pali Roh=C3=A1r <pali@kernel.org>
Link: https://lkml.kernel.org/r/20210910071921.16777-1-rdunlap@infradead.org
---
 arch/x86/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab83c22..16e216b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1256,7 +1256,8 @@ config TOSHIBA
=20
 config I8K
 	tristate "Dell i8k legacy laptop support"
-	select HWMON
+	depends on HWMON
+	depends on PROC_FS
 	select SENSORS_DELL_SMM
 	help
 	  This option enables legacy /proc/i8k userspace interface in hwmon
