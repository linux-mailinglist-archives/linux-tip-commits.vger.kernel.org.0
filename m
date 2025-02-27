Return-Path: <linux-tip-commits+bounces-3692-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D047A478FA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17081884E66
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB289227BB6;
	Thu, 27 Feb 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFWu7s5A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tZbJybQt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C95226D06;
	Thu, 27 Feb 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648246; cv=none; b=AHBYqI0t/rzGsnWmh+/nrlRXRCVLF1kEN33CR56Dqv3fAY2jU2NSF3TZUP+MV3uO42ORWidZoI+QCelyVuzFaSZjuiY0Afl3asOevwuQFAru1KthM5t+JNl9NIK2wY75hi0rbm0FRCxukj+YIHR4P88Lw9WyVn/pYpe3z3YxmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648246; c=relaxed/simple;
	bh=u7qv8oXSxOccGaoQm4UvUhPUjBeZ3q2V698M7kRL8tU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ObcGwQkVXB6tNozqIlD1WFiKYfkfyMAF0uWbb521+uJ39hW5ATqVccxWX9XiPGakZcLEQyCP+NXjSasNXiNVwzDWS3Q1MOAv4WGAnih1Q2oXYit5Dv9QBpbp7repFCNetQUTzIeVhYpjDc7J4Bd6Yl/eAmtgpdT0EuXPmKc/DEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFWu7s5A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tZbJybQt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 09:24:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740648243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEJwZ+58U4TNZ10VRSktiicxpAU7Dlwn/Vlnkzj0Ck0=;
	b=KFWu7s5A6m0l2izvgf5Qom1zA+oiD3UGTZ3XN8uLBNO1fOB26SPWMQCrgGy9fzCKW5uPRh
	rP9tkFn118b83I6HkE7yN3uQUWmXLHSGHJChqBB4TnGByadKoH/XYF8cg8FSO7AGE759i7
	o5OwFwt4m9AAfxJ/V262M1ET8pU9w0Db6i13JUVTOooxJp0SRmvAylrvWb+xW5HpjrbvaU
	kEX8QRIAkGcQamUopsueUaoN1TBJZMcvscI1AnpBbJT7C7YSdNQJ7Cac8ojFcCLHBgv19A
	yHxrHUmWHf4DHkoeGpCMNaA+GaINEYRsyILVQp6T5Xd2b4N8nedGtd08AHvSXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740648243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEJwZ+58U4TNZ10VRSktiicxpAU7Dlwn/Vlnkzj0Ck0=;
	b=tZbJybQtuD3QtRUHgqWUMc5U6yqMc+XsGWeUvdJEF2WQZK4v4VvW/h4CcUrw+Oqv8uEzWC
	sQH+zLQKYl4qEMBg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/bootflag: Micro-optimize sbf_write()
Cc: "H. Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226153709.6370-1-ubizjak@gmail.com>
References: <20250226153709.6370-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174064824225.10177.13942306236102685600.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     adf6819278ba34be1d29ffcdca5c2ccd2123f667
Gitweb:        https://git.kernel.org/tip/adf6819278ba34be1d29ffcdca5c2ccd2123f667
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 26 Feb 2025 16:36:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 10:14:00 +01:00

x86/bootflag: Micro-optimize sbf_write()

Change parity bit with XOR when !parity instead of masking bit out
and conditionally setting it when !parity.

Saves a couple of bytes in the object file.

Co-developed-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226153709.6370-1-ubizjak@gmail.com
---
 arch/x86/kernel/bootflag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
index 4d89a2d..b935c3e 100644
--- a/arch/x86/kernel/bootflag.c
+++ b/arch/x86/kernel/bootflag.c
@@ -38,9 +38,8 @@ static void __init sbf_write(u8 v)
 	unsigned long flags;
 
 	if (sbf_port != -1) {
-		v &= ~SBF_PARITY;
 		if (!parity(v))
-			v |= SBF_PARITY;
+			v ^= SBF_PARITY;
 
 		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n",
 			sbf_port, v);

