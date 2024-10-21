Return-Path: <linux-tip-commits+bounces-2522-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36C9A6E73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Oct 2024 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6FB281C6E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Oct 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF71C460B;
	Mon, 21 Oct 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UM6rfRGQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7QXEqe1U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F481C3F38;
	Mon, 21 Oct 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525337; cv=none; b=uG/m8Znjd6LUfYhXvouNUNlnkXE10VfT1CBweCCUbqXkcyhqVcqs+MW0Qp0I58XRM4diE5Q9OwVUsEsaGU7UXVNh7w85I2le690gQZg1tjLPD8YuugpX/fDWBZZXxu9uFPwxdIVHbQ5Yb5kMIML5831aUWfcm+TIAG8F1dVVsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525337; c=relaxed/simple;
	bh=kq+BTuw6r9N+DOyrFWLlm7tnjZ2yO48DdNGSfXI9IbA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lTDO+q6AbG06IoJXGNl1uVMXiAYavbTHYvHfNk+puzj3nM+TGNK88JKg+EJ4+Toetd4Z2sGW/SUPvF0wbce28v8BuWUEtPlTzQ/X+rXFz05K9Vr08yn1Hw6OcEkHY7MdGLRHfYsWtHtfkmSlhTyN3+WwXKMko68/LbfuH4/xZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UM6rfRGQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7QXEqe1U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 21 Oct 2024 15:42:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729525333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+UIP1lpJkxQeZjrCw/0yVM58Yqk9HXFtas6nlSfeAs=;
	b=UM6rfRGQYrQEYAQoKsSTcVs4UOaCbvohlqI1gfVnkIXKrR2QAK9k1MtuCIVL6JuauCQ4Bc
	IB5O15YeRGQPfHRd1cKUlD7mizV/fb6jy96NdsmafQ+miGu78ArCmhhmhMbQJ1jS5L5kez
	FuwX/vVhZmrna+BeSYpzFDWjEdxJnXqd/MiUYDpIkQgmu+R6Xj1H1cQkmh1Oet2RfYlq/2
	2Sb4DhVtzji+uK/JIe/3163JE7oFflb9nYWog5Rw/AkZ7246aY3jktpYc+FO6jsvog/EKz
	9DYff016uzgzHy2x3Ldwina7dpcoj8mcFlPzPzmWbj5Xk9VHV4bfkA1X2JMNjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729525333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+UIP1lpJkxQeZjrCw/0yVM58Yqk9HXFtas6nlSfeAs=;
	b=7QXEqe1Uzkh1bYAb3gwScOFLTHmfAh0NVLGDPEghjPbKfW/fZ45Bvj+h46X2afjhGmJ5ZH
	CfLascOy70h5KZCA==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform: Switch back to struct
 platform_driver::remove()
Cc: u.kleine-koenig@baylibre.com, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241021103954.403577-2-u.kleine-koenig@baylibre.com>
References: <20241021103954.403577-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172952533210.1442.4307842383237903830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     cdccaab0631812e911553ff56683e9005cd3a51e
Gitweb:        https://git.kernel.org/tip/cdccaab0631812e911553ff56683e9005cd=
3a51e
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
AuthorDate:    Mon, 21 Oct 2024 12:39:53 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 21 Oct 2024 17:20:30 +02:00

x86/platform: Switch back to struct platform_driver::remove()

After

  0edb555a65d1 ("platform: Make platform_driver::remove() return void")

.remove() is (again) the right callback to implement for platform drivers.

Convert all platform drivers below arch/x86 to use .remove(), with the
eventual goal to drop struct platform_driver::remove_new(). As .remove() and
.remove_new() have the same prototypes, conversion is done by just changing
the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241021103954.403577-2-u.kleine-koenig@bayli=
bre.com
---
 arch/x86/platform/iris/iris.c         | 2 +-
 arch/x86/platform/olpc/olpc-xo1-pm.c  | 4 ++--
 arch/x86/platform/olpc/olpc-xo1-sci.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/iris/iris.c b/arch/x86/platform/iris/iris.c
index c5f3bbd..5591a2d 100644
--- a/arch/x86/platform/iris/iris.c
+++ b/arch/x86/platform/iris/iris.c
@@ -73,7 +73,7 @@ static struct platform_driver iris_driver =3D {
 		.name   =3D "iris",
 	},
 	.probe          =3D iris_probe,
-	.remove_new     =3D iris_remove,
+	.remove         =3D iris_remove,
 };
=20
 static struct resource iris_resources[] =3D {
diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/ol=
pc-xo1-pm.c
index 6a9c42d..424eeae 100644
--- a/arch/x86/platform/olpc/olpc-xo1-pm.c
+++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
@@ -159,7 +159,7 @@ static struct platform_driver cs5535_pms_driver =3D {
 		.name =3D "cs5535-pms",
 	},
 	.probe =3D xo1_pm_probe,
-	.remove_new =3D xo1_pm_remove,
+	.remove =3D xo1_pm_remove,
 };
=20
 static struct platform_driver cs5535_acpi_driver =3D {
@@ -167,7 +167,7 @@ static struct platform_driver cs5535_acpi_driver =3D {
 		.name =3D "olpc-xo1-pm-acpi",
 	},
 	.probe =3D xo1_pm_probe,
-	.remove_new =3D xo1_pm_remove,
+	.remove =3D xo1_pm_remove,
 };
=20
 static int __init xo1_pm_init(void)
diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/o=
lpc-xo1-sci.c
index 46d42ff..ccb23c7 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -616,7 +616,7 @@ static struct platform_driver xo1_sci_driver =3D {
 		.dev_groups =3D lid_groups,
 	},
 	.probe =3D xo1_sci_probe,
-	.remove_new =3D xo1_sci_remove,
+	.remove =3D xo1_sci_remove,
 	.suspend =3D xo1_sci_suspend,
 	.resume =3D xo1_sci_resume,
 };

