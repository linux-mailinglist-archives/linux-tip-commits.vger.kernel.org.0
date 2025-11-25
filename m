Return-Path: <linux-tip-commits+bounces-7526-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BBC860C1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Nov 2025 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4487034A3D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Nov 2025 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF24329C67;
	Tue, 25 Nov 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wu3pfbpa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0xfrPcg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFA329C49;
	Tue, 25 Nov 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089794; cv=none; b=Er9qMfR6ufV/4DixvmzXUfgbyH+nKTWdzALyrp+BZTwvBLoVn/scyOW0BJHsyxeTkKgAmTNDNhwf3DNj+y04AZBrZaY9KfgHwT+yNxJHltib2Tx6A2wYsOy8KIzGLpTEpp/56+F8TRpudzJ4vstZ7L3Rrs08fdmDT0j2SpmDr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089794; c=relaxed/simple;
	bh=HNe8jS6Thp3llX4DkBzBDn/UlpiwojRsgC33x/1Gc8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T1bHpSdLD3FnAfcA7Hk2+g/oy/XzakVU4rIdGshhhjgUECRSvWGY4jsgmkT3sVF8eeiUXAqArYaJImOI4GSWDi2SOgPgqUxmlG1uytg76FhcEyUuGTcVeBY1f5DfiYEEQskM3QY9q/sGb0iyuJaL0xycoK5xaBIRkwzRuL+iNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wu3pfbpa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0xfrPcg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Nov 2025 16:56:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764089790;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvND4c0uF2ahhyQr31OeEAxR2fxs3Fv0DK2PvnHMCUU=;
	b=Wu3pfbpaHaAxslS7kWZzj8PjVAt6KbugaaEUAIRkKdW5FSwNvuYAMpjuzIgDCI162X2GOd
	pZ4Oi7xk5rxHE+p9fiH/O1nbJaVDirirln6NMxXduPdNupYbcJSFwrCLK27NdHpTwOlNzj
	j6o+9vFp4UI2GUVM3wbudf06f/K5xlTBF10P32ma1fMTSt/+/GVe/7Oc70d23RC+XtMseJ
	7PU9PHkkN0jbJXXngnQoZZj9W8yrWzCNQ+L4aA07WKhqQFfdz3P7Q8S922JYKO6sghOtS4
	QESR5hVLw7J+R/jHHkulwd1bRio8psepqscLdzvThlKqv1o2TjtqzVCh8sm2pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764089790;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvND4c0uF2ahhyQr31OeEAxR2fxs3Fv0DK2PvnHMCUU=;
	b=c0xfrPcgN1PrG4qBt0EJeBYpn3RjR4khyW/dd5+UgaSgzy0CYSLnwKda5iQEQhTXv2pBJj
	RkCUrT3Ur7OFdMCg==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timekeeping: Fix error code in tk_aux_sysfs_init()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Malaya Kumar Rout <mrout@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aSW1R8q5zoY_DgQE@stanley.mountain>
References: <aSW1R8q5zoY_DgQE@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176408978875.498.9214136366771831705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     c7418164b463056bf4327b6a2abe638b78250f13
Gitweb:        https://git.kernel.org/tip/c7418164b463056bf4327b6a2abe638b782=
50f13
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Tue, 25 Nov 2025 16:55:19 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Nov 2025 17:52:24 +01:00

timekeeping: Fix error code in tk_aux_sysfs_init()

If kobject_create_and_add() fails on the first iteration, then the error
code is set to -ENOMEM which is correct. But if it fails in subsequent
iterations then "ret" is zero, which means success, but it should be
-ENOMEM.

Set the error code to -ENOMEM correctly.

Fixes: 7b5ab04f035f ("timekeeping: Fix resource leak in tk_aux_sysfs_init() e=
rror paths")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Malaya Kumar Rout <mrout@redhat.com>
Link: https://patch.msgid.link/aSW1R8q5zoY_DgQE@stanley.mountain
---
 kernel/time/timekeeping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 08e0943..4790da8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3073,8 +3073,10 @@ static int __init tk_aux_sysfs_init(void)
 		char id[2] =3D { [0] =3D '0' + i, };
 		struct kobject *clk =3D kobject_create_and_add(id, auxo);
=20
-		if (!clk)
+		if (!clk) {
+			ret =3D -ENOMEM;
 			goto err_clean;
+		}
=20
 		ret =3D sysfs_create_group(clk, &aux_clock_enable_attr_group);
 		if (ret)

