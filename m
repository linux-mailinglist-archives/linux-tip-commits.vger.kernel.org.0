Return-Path: <linux-tip-commits+bounces-6865-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA4BE28B2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761DB480587
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208ED321421;
	Thu, 16 Oct 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGX/wAVP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BX+/31gw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1B2E0B55;
	Thu, 16 Oct 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608342; cv=none; b=STPmp/V3zcUQ/u1UMcSgAzP3521M03Hg0h3wBkrDA7YQw6eaKQgkNEOVTxaxuYopRXiNhIpaobWC7GycYXUWcTApOvwcPUvqizdoR995S0ygtNAyutKWVvHviYedaj7LpVOUimCC1u74ZpacRQq3P0fzWMK5CBt572aWEDAeHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608342; c=relaxed/simple;
	bh=0ZlPaKOpAo03v5pcmdgtHNCnDqbQgvGq2ulKpgYErSk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=B9PGaecqSpXXDRzGtzX51z0E9DVpRsnpUwCgGTwMg1QjLelZB4OeBRVCDEzn6icO6Sv1GzW4J3bYeQxJCo+iDA+5TKie3dRqbMB57OasHvQ5eljHA+gbJ92BM4T0DkDO1iVkvu1be9cZspQb4NK2Ay1hvRcAC0eOpYsRP+aXdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGX/wAVP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BX+/31gw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f4FYb3WkGExjpKehflSnHqiMBIZA3zLHK2k46u6npQk=;
	b=HGX/wAVPM2emJFYIdhyV8P7zwU6MEWynPpI2DmqgYPlKuehlXTp37qSX7+pk3I17PuUmlZ
	JtB3kywc0sRGeR4nL4f48ORPSpC8cwVfTWNbvcyryMu7oAdvr5NBHAyj/cPYhsfa97iS4z
	nxRR3nD+I4fbopGx0qOhr7KPFAQqcRxpUBSk4yyDo8qM9Fp0xVt0hgnH4Nmz2b5K/KVUHo
	g9/bahAIDaIjKZZydiOIMiLDdXV6D+5Sl4XOaSvlksoCC2Xlxio/vSDWLXRgeOKlUmRFen
	VXNRoP3OBfjGhPrbVjbgivPUjfcDhXLkV7cmOhNbbCxbqHpzMDM2dALDucQlFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f4FYb3WkGExjpKehflSnHqiMBIZA3zLHK2k46u6npQk=;
	b=BX+/31gwcT60JN7rtEt4tRUZsOZTASsUOdji8nLAM+qYP4t01Cdrc23hHbjxlpf4yFCNLn
	dFIL+Brpc1toPYAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] livepatch: Add CONFIG_KLP_BUILD
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060833027.709179.8455347560606375641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     7ae60ff0b77f2e741049087a6d1beaf679b91a2c
Gitweb:        https://git.kernel.org/tip/7ae60ff0b77f2e741049087a6d1beaf679b=
91a2c
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:04 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:18 -07:00

livepatch: Add CONFIG_KLP_BUILD

In preparation for introducing klp-build, add a new CONFIG_KLP_BUILD
option.  The initial version will only be supported on x86-64.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig         |  1 +
 kernel/livepatch/Kconfig | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616..ac96920 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -261,6 +261,7 @@ config X86
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_KRETPROBES
 	select HAVE_RETHOOK
+	select HAVE_KLP_BUILD			if X86_64
 	select HAVE_LIVEPATCH			if X86_64
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index 53d51ed..4c0a9c1 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -18,3 +18,15 @@ config LIVEPATCH
 	  module uses the interface provided by this option to register
 	  a patch, causing calls to patched functions to be redirected
 	  to new function code contained in the patch module.
+
+config HAVE_KLP_BUILD
+	bool
+	help
+	  Arch supports klp-build
+
+config KLP_BUILD
+	def_bool y
+	depends on LIVEPATCH && HAVE_KLP_BUILD
+	select OBJTOOL
+	help
+	  Enable klp-build support

