Return-Path: <linux-tip-commits+bounces-2215-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0B2972076
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8B9284FD1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C0179970;
	Mon,  9 Sep 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1UNT2jBN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPAZsjXo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C816EB65;
	Mon,  9 Sep 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902864; cv=none; b=krI0aqRnkPB94P4AlRa0z8ykYod/p3NsYHUrTpIdGqfSkRt41oTCW9DjLJDfXBfA+WxbVRjR5m4D0QWiAWleIdB0ou9Eg8U92QmZ9CnNh+U6CYkbSNrR8tVQgvYfnk3qfZQl1bv9O3j4rwMrBtVt2gjQJKDhyEgBogB1D4VZ6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902864; c=relaxed/simple;
	bh=B/73IEAPLayYpPfWqYg+q4C3ZbnnOWHkVTEAilIiyVs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XMRYmC1VnRk4N+avCrLSQK/KDpwfjpnOR3eHDynMVA5BctL/nLPhDHPjQffV4lUmqcMx6i8poJIKBHnlr4v3O2++v1GdEjA8uMScEhH3ZtJYa/JpA/fOtOrjG9l+zn4+cjCRDmtG2J8BOkCBHto7Ekf0Pi/iZLMDZ0E9cv53yOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1UNT2jBN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wPAZsjXo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5im82oGiUFihike5/eRPnXdi7Z+l4zd4Dc6yJCIw5A=;
	b=1UNT2jBN89H6NtJSlsRpFz1dHtA28O7yfKLw/l0c8i5C1vqEg/Q8CZ91az3gzwz+LWH+MB
	+D4FjhhPGMAQ/3F8K93Em/RKNbgHgPCGpMhGUQpEIyV90qszMR73urpmCNp86Y16636ayJ
	GBDHAFgLj2cfFaty1xbyoIIsK7GhhXrYsEh1b3h8B4m1H8xIAfRa4yX4+gX++zRxCVZhib
	qboxSe7LvUsrzEMax/6N3KR5yArXi98i0PSZHkDlZFiu/crRFc83gc5KP8ZvaunJ/xzopx
	w3wtJnr7CR1fN62Ge0ZXvoj43ElLH5ZzGPL47DQQiGFRBNHxGIdEOidgan/NYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h5im82oGiUFihike5/eRPnXdi7Z+l4zd4Dc6yJCIw5A=;
	b=wPAZsjXoI8Bz5+c1hnSG0uAjzoojA0v7f7FB2NCDyeq730TPAiKYOmkMNyHRNJdn4gZ6LF
	XsKlirdjxG05UODw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] x86: Allow to enable PREEMPT_RT.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240906111841.562402-2-bigeasy@linutronix.de>
References: <20240906111841.562402-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286111.2215.4810009143872895730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     70c5e36c0f431cab9059477c6b7d3ba02b289cd9
Gitweb:        https://git.kernel.org/tip/70c5e36c0f431cab9059477c6b7d3ba02b289cd9
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 06 Sep 2024 12:59:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Sep 2024 19:24:11 +02:00

x86: Allow to enable PREEMPT_RT.

It is really time.

x86 has all the required architecture related changes, that have been
identified over time, in order to enable PREEMPT_RT. With the recent
printk changes, the last known road block has been addressed.

Allow to enable PREEMPT_RT on x86.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240906111841.562402-2-bigeasy@linutronix.de

---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9..8768d38 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -122,6 +122,7 @@ config X86
 	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST

