Return-Path: <linux-tip-commits+bounces-1857-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97C94141E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08876B23DF6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4581A38E0;
	Tue, 30 Jul 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F4FAOXvo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EM5m+nUA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D581A2C15;
	Tue, 30 Jul 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348919; cv=none; b=er/UwWe2gXE54+9+WzmHiswp8ovpVldXSpvMrgthQKkROXYpGUMFw3pKxGEjzh3zeEFMcHf/+xZ9ELydFgev7xqJbt3tpQ1qXZNMTr4AZ0Ea5AWs73B31x/rW31q5s6DqBjD+MciRaHRHVbWUIJ/JlJejqIu2lmQxw6STNon9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348919; c=relaxed/simple;
	bh=9Mwg2RiXbWTdnPvX5xPkBsSr6NCLmOqn8P7beQWJO2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AIVGUhlPxciLIK3iTDi/x46r1jELXxftVfyvZxI0t+HD3sFKyWfVzn0mvcQGL9uF3lT9dMOGksS7AIiq5Nz/uCg0MSHT9CD7RppD0FHejz3rH9BcpNfTk+L3LLJR++Wo7Ru7chtG1BLxftCRNXC5GjcfHg9gLe1LhPB8WGjpeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F4FAOXvo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EM5m+nUA; arc=none smtp.client-ip=193.142.43.55
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
	bh=BYw4pNeYFg4p+iSCPk7VrsebhYwvj6V2GkVdHuKYGXE=;
	b=F4FAOXvoHAYcT3AKI7r1vb68BMwAj3XlXk4P+m++BNP4k/ApQxE0WeSAe+vfc5a07FiH0R
	N0T4CfH2QjAXAGrEo+g3G5Ljv87QX3WWd1O0ACsyR4hdMhrtqIQ6DSIYVZxodyb8L8FPV+
	DKfNzT5UTt/i5aj5QGB1HAUuDwSqGGhAoyLYBzUFiAIxRRb5ikeUCim6S7QSSEyH6DQoeh
	f1nhHHw4YALtd1+DKI4jlxTSl0c8NjBMfYKhdAxzQTbk1L0WoaOYAww3GdJjhotynDwlU4
	eJcTKCcP9CMcOk0fCFUjVDraelIJHkaLXWCmvxsZwe9deMZ7GqgoRvwtXk86Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348914;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYw4pNeYFg4p+iSCPk7VrsebhYwvj6V2GkVdHuKYGXE=;
	b=EM5m+nUAbLtSRPeJ/SmI2xkiIDuRkVPhmEoMkvn6VFJcUWoZ/VB5CbwaW+KI3RFi/3Dwxz
	AdHc9Yv+QJ5OocDw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add a separate config for L1TF
Cc: Breno Leitao <leitao@debian.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-5-leitao@debian.org>
References: <20240729164105.554296-5-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891401.2215.11552534181932998212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     3a4ee4ff819b2bd09f1eca4a90846f2be449bd51
Gitweb:        https://git.kernel.org/tip/3a4ee4ff819b2bd09f1eca4a90846f2be449bd51
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:52 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 11:23:17 +02:00

x86/bugs: Add a separate config for L1TF

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for the L1TF CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
it at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240729164105.554296-5-leitao@debian.org
---
 arch/x86/Kconfig           | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b169677..290f086 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2682,6 +2682,16 @@ config MITIGATION_MMIO_STALE_DATA
 	  attacker to have access to MMIO.
 	  See also
 	  <file:Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst>
+
+config MITIGATION_L1TF
+	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
+	  hardware vulnerability which allows unprivileged speculative access to data
+	  available in the Level 1 Data Cache.
+	  See <file:Documentation/admin-guide/hw-vuln/l1tf.rst
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9b0d058..4fde9bd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2374,7 +2374,8 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+enum l1tf_mitigations l1tf_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif

