Return-Path: <linux-tip-commits+bounces-7957-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8CDD1927D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 826DF3015190
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA40392B8A;
	Tue, 13 Jan 2026 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40GB8uk4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H5w47lvM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4BE392B64;
	Tue, 13 Jan 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312068; cv=none; b=pmpF6QB7jUMA+cXuSSpY8w/ZU5Moz+2cIxCY82JbahiWzB0NWA62+L65y/sX6iSYpyf70ePNFPMEWR/g55f6lDFism/5yIBiiCNv29P5ZN/ybMhJqKCXfWCzPRXpn7jtGFZtwTidTnd472mvFNMNVgicpdc7qUqs7om+ZP83wSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312068; c=relaxed/simple;
	bh=CamsQr9hzMlOA29VWVLb0ByxdzOhPbHkHnh4zutqZ8M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WPFpurIvGdmzvzwi5PiarUole2lQGpYS/shX7MQCFgcL3OZzY9RKTkVaP5qoGUV+0IOs5BjBPhQCYsoqOqU9v7FBunyGO9/jdd/NIlyNIgf2xZJzZvjx1S6eH5lPH2R70D6yWrNW2lglS0+1VvHdV1EcZN5HbiHhF/3AF8ACQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40GB8uk4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H5w47lvM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMo00sdc9a0dUt3PmNFOvvVDJ+Fs0typBNQRBkaqWe0=;
	b=40GB8uk4t+FxdRSSpnbczJkelJ7zqHtzNwrnCNrKkagnfiNjZLbLvdka3EtMg2O2DkBjCQ
	8N8WwWeOlymlEZ2iCJviIWPuWs4srUEQxCJbalvbrZMgjRpAgHU2W0zL71Dn+RfapB4DT4
	OoAvT5k/0axZLsv8CZBdhnBmQWiUA6XGf/Qla9T5XQKv8skRL3WI1d9Vpji7nn/T0YpxwE
	tc9DIagDYCFiVQrH3YEEAqLsPSbqaWyNkRPyvXYmMUngDiKvjieQgEplf94AhuDPh+U3mq
	/B5bRrGs9mysy6h3e1yHErPj0//fkbsn3CyYFX71pBPubiJS6cdsUH4EndNjdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMo00sdc9a0dUt3PmNFOvvVDJ+Fs0typBNQRBkaqWe0=;
	b=H5w47lvMWOFyyQhMgl2zLca8MZEyFcSig2OAEEr1uajzvepBSYms24mT1jy+UvOZXEN2PK
	T7UiYj1I3DIKcvBg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_config: Add configurations
 for clock_getres_time64()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-2-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-2-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831206101.510.14830716438036486098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     609e359ab904698f1e5aa0ab2fee2f4c29ee0886
Gitweb:        https://git.kernel.org/tip/609e359ab904698f1e5aa0ab2fee2f4c29e=
e0886
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:13 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

selftests: vDSO: vdso_config: Add configurations for clock_getres_time64()

Some architectures will start to implement this function.
Make sure that tests can be written for it.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-2-97ea7a06a543@=
linutronix.de
---
 tools/testing/selftests/vDSO/vdso_config.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selft=
ests/vDSO/vdso_config.h
index 50c2610..5da2237 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -66,7 +66,7 @@ static const char *versions[7] =3D {
 };
=20
 __attribute__((unused))
-static const char *names[2][7] =3D {
+static const char *names[2][8] =3D {
 	{
 		"__kernel_gettimeofday",
 		"__kernel_clock_gettime",
@@ -75,6 +75,7 @@ static const char *names[2][7] =3D {
 		"__kernel_getcpu",
 		"__kernel_clock_gettime64",
 		"__kernel_getrandom",
+		"__kernel_clock_getres_time64",
 	},
 	{
 		"__vdso_gettimeofday",
@@ -84,6 +85,7 @@ static const char *names[2][7] =3D {
 		"__vdso_getcpu",
 		"__vdso_clock_gettime64",
 		"__vdso_getrandom",
+		"__vdso_clock_getres_time64",
 	},
 };
=20

