Return-Path: <linux-tip-commits+bounces-3524-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E1A3A454
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 18:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166B8167DE4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 17:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8826FA66;
	Tue, 18 Feb 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDxbiW07";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3eED4nZl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0B286A1;
	Tue, 18 Feb 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899750; cv=none; b=HIofuxIQGNHdvjhFvFUpw/rc7AnS+9kEHuhg3oZuuO/2TOS8uo/JESapIIeuDONVOB/jR66cPnrgyzquOpe3o1JMwhCpG1bitp5m+kGOvDYI63A8gr6JjmxLEXOKu3kDgmzQk4p649VnvfYoiXFErw5E42lqf9AUKIzcX+6gjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899750; c=relaxed/simple;
	bh=MxI8M2wbkcp+37wHzG/RfF0zP5KTWHkSheAyaIx5QBc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fztfSzBaPfn0vvSqXyxVRlWC4ruUN0jpTkND8DIZjWdn2BblhxACIaIV2RId/q+E0C15gTSPfnlZJLSt6Ru4QOCXliMplNzMsnlGn1PpODuJlTEzHeU0yaS2nIbw63WW4edwNOgW/l2hwTf/TZ29W/JfSV2d+atI+iphgZwfko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDxbiW07; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3eED4nZl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 17:29:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739899746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqKHgAVf+wjocvxnCDI3yCoH+0U6NFgRgYV5Thtzqgg=;
	b=EDxbiW07sfLsM2zRbeJKV+abjbTSOligQj94eHCU+9WJCLknDSe57VtrDGeHC/bMyWbPhY
	BX+TLMK2iqnbLCwSfPcV9DsGl2WD9+XMuc+mNFzOtOsDx88eUsCLnR+dIEGO+pInDnzTer
	DScAiBEovUGX2xMjVO4rQaBUroo5fAHMS6wQZUjVqCNYY2x1aFroV1BiIGI+c6kfG7ozbL
	Tfv9y9pZle4eNN0LXs2KKitTgMYf1U1v+LO5b8E6vZPTsHG83jQ1B4z+tdNrvc5JnJ7KZg
	W2frGZJ+66tYYo13obUAN40fl04HaLLcT/6lZVTlu5J21IkTN16xSMJBoU8eQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739899746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqKHgAVf+wjocvxnCDI3yCoH+0U6NFgRgYV5Thtzqgg=;
	b=3eED4nZlsIOa8aVCrI0mJzE3zhEp/lTu0rgJFX212Sn1zQl7TUPCwJRoIG5dWKyFTSJRM6
	et84OWvgLjllCaCA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_node: Add a smn_read_register() helper
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250217231747.1656228-2-superm1@kernel.org>
References: <20250217231747.1656228-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173989974292.10177.3977427168807711894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     c893ee3f95f16fcb98da934d61483d0b7d8ed568
Gitweb:        https://git.kernel.org/tip/c893ee3f95f16fcb98da934d61483d0b7d8ed568
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Mon, 17 Feb 2025 17:17:41 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 18 Feb 2025 18:14:29 +01:00

x86/amd_node: Add a smn_read_register() helper

Some of the ACP drivers will poll registers through SMN using
read_poll_timeout() which requires returning the result of the register read
as the argument.

Add a helper to do just that.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250217231747.1656228-2-superm1@kernel.org
---
 arch/x86/include/asm/amd_node.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 002c3af..23fe617 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -46,4 +46,15 @@ static inline int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *val
 }
 #endif /* CONFIG_AMD_NODE */
 
+/* helper for use with read_poll_timeout */
+static inline int smn_read_register(u32 reg)
+{
+	int data, rc;
+
+	rc = amd_smn_read(0, reg, &data);
+	if (rc)
+		return rc;
+
+	return data;
+}
 #endif /*_ASM_X86_AMD_NODE_H_*/

