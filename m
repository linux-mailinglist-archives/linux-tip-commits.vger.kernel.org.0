Return-Path: <linux-tip-commits+bounces-3248-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC2A11ED7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 11:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE7D16772F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAFD2361C9;
	Wed, 15 Jan 2025 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pr+xqMIl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iYbOtc4v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70420AF87;
	Wed, 15 Jan 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935458; cv=none; b=eRlObsv5xbHdkTlVoe3zQH7tPUmX3oXxFVT2126ZvLB6/0Z5pt7NIhNDbGBcdahkgyem2hc19gdv7SfSfCYDlzIcSEWBuIUKF3dRitSFalwZg2ZAfcLIyFOn0i1Of2U/lpuk/z3f/NPsJ7aVIxwnA/GtvDMJJ0rEVkKThxdpEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935458; c=relaxed/simple;
	bh=hWlhJczXfa7wwASlqMFc81zmrzHh1EPeezphW8KXo1s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mfp2Bnrsbu1027Odnefi0ExoJpxB/FI9+HTHPFWEIw+VPtjKPGfMb+q9fSr4gOfTIXARhXuvuCmI/3I+xiA0adeOKrJcM6OmKgx68cck4laCzGFdys81mo82L3NKmE3vr4Utl4KzECDLnpINqkQkv3YrfhynYJWVsPUaNL1ne+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pr+xqMIl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iYbOtc4v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 10:04:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736935454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3zUE3BnKEobIYixeI4ELsXt/ejcoaAwh0zfk4x5Yho=;
	b=pr+xqMIlwlDjhmWZlxFfx3ICXB03/nTPr5xIGRu4vr8TciXd+Hrv5QS11Mj8L4rBLY0US+
	W+ZpBxIVxGHZEqBu4XeZkJ7y0EwePB2nVQlIEjUNVn3N5vDUTrMegRB6K0qRNqguiJB3Oe
	vPU7F85HiyhY5780LG2cIPnlas5c2fYHdSRFPD78Ly6+gX7XEoUVE2T+FFc194N8HdTVAO
	GOyNrhDO2BL0kxVXG6fZGdoGZlbJ6TbUDEShIQkQ+kjaF/zhoiTxzZuzkBqowbs9b37kUM
	FT0uN96WR/IwL+Uf7n7/KHEW3SY3Gx7qcMSBc6fhxgTumuVMaf2pBnVyd3gMHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736935454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3zUE3BnKEobIYixeI4ELsXt/ejcoaAwh0zfk4x5Yho=;
	b=iYbOtc4vh8pYwRKCgZ69M8CUmf9pmOKbrSIisG/OOcP8kaGeXFAQ5ZMnChrPXfTCzPKyR7
	jayAJvd4IXvu2ODA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] hexagon: Remove GENERIC_PENDING_IRQ leftover
Cc: Thomas Gleixner <tglx@linutronix.de>, Brian Cain <bcain@quicinc.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241210103335.437630614@linutronix.de>
References: <20241210103335.437630614@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693545436.31546.14271252836745457454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     65d09d269fc15b4d8bbeff950ecdc4dc36a6961a
Gitweb:        https://git.kernel.org/tip/65d09d269fc15b4d8bbeff950ecdc4dc36a6961a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Dec 2024 11:34:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 10:56:22 +01:00

hexagon: Remove GENERIC_PENDING_IRQ leftover

Commented out since 2011....

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Brian Cain <bcain@quicinc.com>
Link: https://lore.kernel.org/all/20241210103335.437630614@linutronix.de

---
 arch/hexagon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 3eb51fb..d987ba3 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -20,7 +20,6 @@ config HEXAGON
 	# select ARCH_HAS_CPU_IDLE_WAIT
 	# select GPIOLIB
 	# select HAVE_CLK
-	# select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()

