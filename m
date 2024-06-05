Return-Path: <linux-tip-commits+bounces-1340-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F02308FC555
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 10:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874A91F212E5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B4A14F113;
	Wed,  5 Jun 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1qpK8XM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+p4el+xK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141BE1922FC;
	Wed,  5 Jun 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574710; cv=none; b=nTqNVm58oppNPvMy/M/OT2Yrs9q2zU5I2AeB4tbRWczqUmwQujZ3XXiSJNNs+jpnQdy7mOZ112LkuSraAwwJkrAw/nDT6Ua0crEjiRo4uBTo1vtyE50OKds5Q48RjnkOExfNIFzVo0MbjyZqmjqatb/uEddaPngQnZYFSmQPxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574710; c=relaxed/simple;
	bh=b4p8eEI2U4qC9glBv0EWb7H1HwkXR8cF4asHbORoZWg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AmiCAq+ZrKs9zG5duXYYBM2kbLGmP2BynTSEof++ISCvFB4oBgquosk5SAqijadB8qJsDN4ypkzFbdVb/3Jqp3srP+KyarHoOpGr06L4c2t1Ia6SZZj0lU/Ploz6lvG1yYa2YB0PBDlqz9TRAQM9rjyArt9akQ42aCcYzOsdNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1qpK8XM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+p4el+xK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 08:05:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717574705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xenF9RbgPjHNqBJqKTeAURBpnhxtLmauk1Wzc33aoNI=;
	b=I1qpK8XMub2F6RUD+ZtVnz1XK/wz3OvJs602kTze9K36L72Ql9Jd8jWVI9eppedHmWHW/C
	5c4So/pSSe1sEENdZwTS9v8+j/s7gY3QylWBKPDAqclAv8y4H6V6u33aPnw88s4Msy4mHN
	HruAgXBisUku/wW/D+RgMGYEgrG02gyQuWIDneXdw+3+tkXDbZERmFdanM+MCtxcY4n0Wz
	yAR77JsLsZnkNKMyZiA7QH1GRVcFt2T4OtuQop7lY5xgPEvxysDKtZXbEvUh3b1f7iAUyh
	ycCbaQiRtEki9RPL0Bi/V2gOfpSvDM4pX/zl/3i4nK/b7fQ6l7yiaFymj/YzEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717574705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xenF9RbgPjHNqBJqKTeAURBpnhxtLmauk1Wzc33aoNI=;
	b=+p4el+xKZ141z3jzZ+pJRqrfpouIIstLi/l0KnjPsoeMNgiiT7g9uhcUlhl1dlVn0ENvC1
	XdQ9DqANUhZMa2BQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kexec: Fix bug with call depth tracking
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240603083036.637-1-bp@kernel.org>
References: <20240603083036.637-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171757470541.10875.11693142669094911973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     93c1800b3799f17375989b0daf76497dd3e80922
Gitweb:        https://git.kernel.org/tip/93c1800b3799f17375989b0daf76497dd3e80922
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Sun, 02 Jun 2024 13:19:09 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 03 Jun 2024 17:19:03 +02:00

x86/kexec: Fix bug with call depth tracking

The call to cc_platform_has() triggers a fault and system crash if call depth
tracking is active because the GS segment has been reset by load_segments() and
GS_BASE is now 0 but call depth tracking uses per-CPU variables to operate.

Call cc_platform_has() earlier in the function when GS is still valid.

  [ bp: Massage. ]

Fixes: 5d8213864ade ("x86/retbleed: Add SKL return thunk")
Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20240603083036.637-1-bp@kernel.org
---
 arch/x86/kernel/machine_kexec_64.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e..cc0f7f7 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -295,8 +295,15 @@ void machine_kexec_cleanup(struct kimage *image)
 void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list[PAGES_NR];
-	void *control_page;
+	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
+	void *control_page;
+
+	/*
+	 * This must be done before load_segments() since if call depth tracking
+	 * is used then GS must be valid to make any function calls.
+	 */
+	host_mem_enc_active = cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
@@ -358,7 +365,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
+				       host_mem_enc_active);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)

