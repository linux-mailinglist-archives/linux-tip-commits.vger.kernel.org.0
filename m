Return-Path: <linux-tip-commits+bounces-7427-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A228C75411
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 17:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CA164F117F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B481376BE7;
	Thu, 20 Nov 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J/WsMpp/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5EfWJZge"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F7376BCD;
	Thu, 20 Nov 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653466; cv=none; b=RmFTegHtth3AmPtj4QvDRwt2UcE2yZEEHP4fVdBmn9cqMKRKQxRmqt1kdLay8R9lPPKU6/qedfq+sGYuQGwVq1tckVmAWdiiPNcQzLmCAY3kBea9gINT9mZN6o9NWN3vTQWocL4M6cEBpnkWW7tet3cLJW7qBGSBZV+ZHdnXubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653466; c=relaxed/simple;
	bh=7GaoSjUQUAxhxQe2c+DT7hAVjkKM49nVt15IGuGtDrE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V44qgTe6J5UNI2k0wV4LdJ/Mn6hDssD/ibfqIVZKrd9I+P6+LTWc3AtBXBBIX/QShckRWE3Q9kvaueb1yvWjsyylyVw39JnD+yfV1GwUdn+IFQiHZKRzHzuTkoEvVsVNAtlhsDKDbofCyeaZxcd3pVt0kNFfUQeYv1CI5h+FZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J/WsMpp/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5EfWJZge; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 15:44:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763653462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqvO480pDJllSRs4Se8VyxiNNBafwlq+4vKHAwfO+Xc=;
	b=J/WsMpp/T0iMrVfyBMaguX5cjclbaNHXB/s4KUsyp+Tsx2LBgX0opyEY7m9nuu+Z+LYPX1
	/IVE6TILMCjSMxGQjsol3dRWpP++b+izNDWgqtxFIGdLe4S0uZbBnAl5UJWtomGwdz0jbt
	/p6O2VL4pMubYed6nEMweFSu5lbQ2FbJ6qy3viCFGym6q7F4NTkMO+2EVHSU1svqZy/Gen
	VHMLQ4fEMPax81RCUvFuZpsatvXniPBrOMnKXSnrCqD9dhy3LI0gTKcgkE9nBhXmEFZa3F
	unIt6VG95oFi/6SoPnHB6e3TrFGJrPMq51VGb67oRbxb1gDgO4kXvD7mz02uhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763653462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqvO480pDJllSRs4Se8VyxiNNBafwlq+4vKHAwfO+Xc=;
	b=5EfWJZgeOq69L3/mTrjtrE2CYcF2xRdWm4Ff5ElEcUt2jhg7mI6k4oU+QJF9f8batSBqOD
	Vyr0kvjh9O+MqyAA==
From: "tip-bot2 for Malaya Kumar Rout" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Fix resource leak in
 tk_aux_sysfs_init() error paths
Cc: Malaya Kumar Rout <mrout@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251120150213.246777-1-mrout@redhat.com>
References: <20251120150213.246777-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176365346146.498.12108984276510193659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     7b5ab04f035f829ed6008e4685501ec00b3e73c9
Gitweb:        https://git.kernel.org/tip/7b5ab04f035f829ed6008e4685501ec00b3=
e73c9
Author:        Malaya Kumar Rout <mrout@redhat.com>
AuthorDate:    Thu, 20 Nov 2025 20:32:13 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 16:40:48 +01:00

timekeeping: Fix resource leak in tk_aux_sysfs_init() error paths

tk_aux_sysfs_init() returns immediately on error during the auxiliary clock
initialization loop without cleaning up previously allocated kobjects and
sysfs groups.

If kobject_create_and_add() or sysfs_create_group() fails during loop
iteration, the parent kobjects (tko and auxo) and any previously created
child kobjects are leaked.

Fix this by adding proper error handling with goto labels to ensure all
allocated resources are cleaned up on failure. kobject_put() on the
parent kobjects will handle cleanup of their children.

Fixes: 7b95663a3d96 ("timekeeping: Provide interface to control auxiliary clo=
cks")
Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251120150213.246777-1-mrout@redhat.com
---
 kernel/time/timekeeping.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3a4d3b2..08e0943 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3060,29 +3060,32 @@ static const struct attribute_group aux_clock_enable_=
attr_group =3D {
 static int __init tk_aux_sysfs_init(void)
 {
 	struct kobject *auxo, *tko =3D kobject_create_and_add("time", kernel_kobj);
+	int ret =3D -ENOMEM;
=20
 	if (!tko)
-		return -ENOMEM;
+		return ret;
=20
 	auxo =3D kobject_create_and_add("aux_clocks", tko);
-	if (!auxo) {
-		kobject_put(tko);
-		return -ENOMEM;
-	}
+	if (!auxo)
+		goto err_clean;
=20
 	for (int i =3D 0; i < MAX_AUX_CLOCKS; i++) {
 		char id[2] =3D { [0] =3D '0' + i, };
 		struct kobject *clk =3D kobject_create_and_add(id, auxo);
=20
 		if (!clk)
-			return -ENOMEM;
-
-		int ret =3D sysfs_create_group(clk, &aux_clock_enable_attr_group);
+			goto err_clean;
=20
+		ret =3D sysfs_create_group(clk, &aux_clock_enable_attr_group);
 		if (ret)
-			return ret;
+			goto err_clean;
 	}
 	return 0;
+
+err_clean:
+	kobject_put(auxo);
+	kobject_put(tko);
+	return ret;
 }
 late_initcall(tk_aux_sysfs_init);
=20

