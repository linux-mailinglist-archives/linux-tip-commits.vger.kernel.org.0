Return-Path: <linux-tip-commits+bounces-1859-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B661941421
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEE11C22CD1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41671A3BA0;
	Tue, 30 Jul 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BIH3MsOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DPXAWemd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B021A00F3;
	Tue, 30 Jul 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348919; cv=none; b=PRlOUZJp9kJ0875lHoNOu/h1xRHqx0CSVG9NzMSz3lhV3/Gv5iJsrW+HFeZHw0Y5/tl3jtXrN+4K0llkbAiAIeC4/UaZcrwEfCFaqscxW0WhUCl99ZnBb36hP8ayGDYt31KQkhn3cpPoJYHuzIl0L/lGrBnQ5PmVkdbsUMGEkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348919; c=relaxed/simple;
	bh=/lYHDxr6iWvrrpKfJnKUJ+RrU8WtVrcaOQXQRRKDqbo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uK0lxebglDGU59/3KM46VmWls97K+wITsqFQkzKf2m9Jeius2mKp0SgOwNXkDA/QCjdC8J5ASzbuqi7bJRgKsQMZ5nLKee06PlnbBkhxjKDjed5RuELHnzmN+bn7KFNG9UKUK5vTF0qxCiXGazoKJ7iv1odlvX97n3zliAMgew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BIH3MsOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DPXAWemd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oMhheQA1b2wQmitnxb9atQ3FWMza5BCqvPd4aXINdo=;
	b=BIH3MsOm1lHcm/gCsyHRCVXrqre9ZPuBtkEKjOiLM5GyuhQa+OYA6EUm+SgPbW574IfB4u
	hgsKntM9cNyBL5HNXQxUxPhC6C0qmOR6/1yKQ+4wEjZgfuIcVgbisqLVLcWovxqZ+iiX79
	sbK+T+nEHdPx61CPdSMyTqA14jGwrZNrLq9J1foguXPplQG1JhT71Qwx4oOM0LoOob4Z6u
	sfy+WBusWChGAmQ4SswoM42UNlZFDJiZgVrua8woDFSmJ+k9srGlclaSmrETPpL8xOfAU6
	fM2ztpmve7sFxM12PL+KxYWgzQCTOs3WwX+jC/+P9xEHfJYihXgBBlTW65Vesw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oMhheQA1b2wQmitnxb9atQ3FWMza5BCqvPd4aXINdo=;
	b=DPXAWemdO8jGzWy6tGXAMWrogjTIc1khMQjoTsD7aYUVtJ6TVaP8g6+1aFHFIWt5+P5G/T
	cH/8nwXZfJXEMxDw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for MMIO Stable Data
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-4-leitao@debian.org>
References: <20240729164105.554296-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891429.2215.1723631809490646805.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     163f9fe6b625c5f5c4d5b05265b194388182454b
Gitweb:        https://git.kernel.org/tip/163f9fe6b625c5f5c4d5b05265b194388182454b
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:51 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 10:56:20 +02:00

x86/bugs: Add a separate config for MMIO Stable Data

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the MMIO Stale data CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-4-leitao@debian.org
---
 arch/x86/Kconfig           | 12 ++++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 712a4f8..b169677 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2670,6 +2670,18 @@ config MITIGATION_TAA
 	  which is available in various CPU internal buffers by using
 	  asynchronous aborts within an Intel TSX transactional region.
 	  See also <file:Documentation/admin-guide/hw-vuln/tsx_async_abort.rst>
+
+config MITIGATION_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst>
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ab30698..9b0d058 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -393,7 +393,8 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+static enum mmio_mitigations mmio_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {

