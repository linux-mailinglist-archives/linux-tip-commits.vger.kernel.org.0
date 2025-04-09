Return-Path: <linux-tip-commits+bounces-4796-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9CA82B54
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62287AE31C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22B267F77;
	Wed,  9 Apr 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLKe4Qvt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mxwNy5hj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33081B423C;
	Wed,  9 Apr 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213725; cv=none; b=ptQfBVdsQmHq0uQCyxUos7VfD0KDlE7zVUW1ptQigibSN8sLIdxGvoXRTxeIOgoa4smdIc+kNFL9YPN/HO6G8dtNMSfRxKqe0IDquxKmorxKgn+a3i5db8SNVt91TlgQre6l3FQCpfmFR29wtddMeTDC9BjkpUrlng32+74kODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213725; c=relaxed/simple;
	bh=21zqOVhJ2Rq/5IPkRUI3IEET6ToGEtyltfJffE9GPqk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cf3zenqEFYJsLsJZGvc/y0hAtJy+dpPWyxQTPLBZAEa6mmXBznBeANNIYwxAVmsAgu6qLW4U94fz5OyaKCNWJNq+Kwsgfz4fuki4AYiqtQRvE/T3KWWHFvdBzpreK20MBRRO71/xk0hp5vmg2UMPUfzNIN1m8OcR741jBbIISwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLKe4Qvt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mxwNy5hj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 15:48:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744213716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7iMr7lCZRq85IJ6t7DIZfsLQU70nnQxRTR/udw1pzmU=;
	b=SLKe4QvtTPuH/JfdaYEAHGzw74KfS8w11g6U+sp0PVuh6G1ezH4aoDsDoBYES2wDRXPJe/
	fsgvHj5e3iZhGbhywA8Sxbstoip6yFDX03Ojdef1wm8nAiLzBLIJ6Ggn9p1NCDKtsdOZdL
	mKxOluyvgfjgNFslGIJON6+aN3g9roNS0k35pm1+Wi2E8lrvrepy1vasEBjtywpd7SIpzM
	8Nz6TJHhtlj+8PuK9Uy2kA0L0eV1ohAkXOzL6K+eTE7gDFq0/w62IPC0QM/M79B2EKEdXU
	eUv7MoBnLQNdsh8pb32TUipf2Y/9DDbWAuq5Lyzpt2sTnICKdZiqsfYTUpFcHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744213716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7iMr7lCZRq85IJ6t7DIZfsLQU70nnQxRTR/udw1pzmU=;
	b=mxwNy5hjhSpee2uRlopNldM+NRGDvA+1stDitNKQwZgJO7fYZKRwJ/6cs4O2v7oCx7WUwl
	ZTluBCpayqV7UECg==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpu: Avoid running off the end of an AMD erratum table
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174421371162.31282.17082226366215885447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f0df00ebc57f803603f2a2e0df197e51f06fbe90
Gitweb:        https://git.kernel.org/tip/f0df00ebc57f803603f2a2e0df197e51f06fbe90
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 09 Apr 2025 06:58:37 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Apr 2025 07:57:16 -07:00

x86/cpu: Avoid running off the end of an AMD erratum table

The NULL array terminator at the end of erratum_1386_microcode was
removed during the switch from x86_cpu_desc to x86_cpu_id. This
causes readers to run off the end of the array.

Replace the NULL.

Fixes: f3f325152673 ("x86/cpu: Move AMD erratum 1386 table over to 'x86_cpu_id'")
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 79569f7..a839ff5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -805,6 +805,7 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 static const struct x86_cpu_id erratum_1386_microcode[] = {
 	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x01), 0x2, 0x2, 0x0800126e),
 	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x31), 0x0, 0x0, 0x08301052),
+	{}
 };
 
 static void fix_erratum_1386(struct cpuinfo_x86 *c)

