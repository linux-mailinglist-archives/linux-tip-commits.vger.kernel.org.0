Return-Path: <linux-tip-commits+bounces-3317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E11A25A11
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2861165491
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80810205AA6;
	Mon,  3 Feb 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOBHOA9L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uj18GhZv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA320550F;
	Mon,  3 Feb 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587006; cv=none; b=FLPZuG+tMATPbyvsS36fccXovsdsA2lEiCBLrVjkWPrbS2pD4eEMTsDKAjA0KdBhTpqq+qGZV/msql2xbbu/MJgz8G4CK27aEXmBmkobYVOSUJ2pP0Lb53xwKASqjCRQ8MLs4SJcsnLmVfjTmgyMJ7uvgZ9vaG+GUJj42hOyjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587006; c=relaxed/simple;
	bh=BUfC5F6IykvGFdrjNkVCuH4DLX/MpUphugiqqYZee1s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uBVILUON/qK53gk3RljNvj88jUC36vjhRGz7EkOFMx3s4aSBrqwApRIbaLWnchXYZF6HKqQsuHoh3NIFx6Miha2S25fIbQ+bVHfal0rC143QTzAdV7xXH8+3e4/FXp/9M0sPxArrqQ0dNj6bGfdQkqbaPqzCmYWvACfm/RKxqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOBHOA9L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uj18GhZv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738587003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yQwftTzn7695dzrD96rKJIyYDF+Xf3QK4QkXse75m0=;
	b=OOBHOA9L0ma6gvpqhQDKAtTIpvk3JSCUgUpPRKeVFq0lBUERIv3KJ+pJ/Dpi86wn/tkx7Z
	fILELgcslAo2b5UNfq+A0sSZUQk84idB0SET5KP0/4WFtgaKj0iPqEHAzJJSsGV5sj0On6
	OvdFJ7hTcQo3zibMsgx9uZGxuUUHU+rz8I2CHTGkb1AXCzB/d92W3R2p4LaQcbg2XkfFLu
	r5lnRc5x+Aq5z7wBHp3y62e2mf86OD5YWw5k8WAC9EugE4W3Oq/DZrnv+k5C+S09T2xDjj
	ssUgn/8MoJi9qfJ+llace53oqcsvb9YvLeZCQUU4sZNQM0pMJJnQDRTwlY48tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738587003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yQwftTzn7695dzrD96rKJIyYDF+Xf3QK4QkXse75m0=;
	b=Uj18GhZvBGA1cWkYdocAWWv0ADrUZPt17DpZWXn5ju5k20w+4jiJ95kglGVQNGerXC7FbI
	Ne6pQ+mKqB/LzdCA==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86: re-enable EXECMEM_ROX support
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250126074733.1384926-10-rppt@kernel.org>
References: <20250126074733.1384926-10-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858700273.10177.1491229953597809095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     64f6a4e10c05ed527f0f24b7954964255e0d3535
Gitweb:        https://git.kernel.org/tip/64f6a4e10c05ed527f0f24b7954964255e0d3535
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Sun, 26 Jan 2025 09:47:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:03 +01:00

x86: re-enable EXECMEM_ROX support

after rework of execmem ROX caches

Signed-off-by: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250126074733.1384926-10-rppt@kernel.org
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d9..6df7779 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_EXECMEM_ROX		if X86_64
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL

