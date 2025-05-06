Return-Path: <linux-tip-commits+bounces-5270-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C747EAAC5A9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78573A4AF7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2408280A55;
	Tue,  6 May 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDjhr6Xj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Th+YM87S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8830280003;
	Tue,  6 May 2025 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537618; cv=none; b=oDHBRdVfm+GhIbm4THdrkFsLrCgq3C6GUXwDCTRLkV2c+/2oMMDYaBPB+jpZr8PKb//aPG2JyGQjpYAEhzrH2T0mqAaUMDzk4qWu1kvdw+sAoJjlO+++9TXK1bqkjjxRBCfDloxZjumQZBJm4HrrByKXVzNLndEbeuPT2doYQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537618; c=relaxed/simple;
	bh=eW6UjRcCaq/sMw8hCcUtdMVTNidm9tzjRn+U1gVcu3k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nEhyDa9ZqIEMDaJUSe5CxMfGDijRIVlGhDy65tOAq07q9Vt/F/sexKTTY34FiLqzoZ7p6lObRZTN5OubE1T0wLinv0/W6ceqKhhcEMPgR0Juof2MrD1Ws80zxQzRPnnmDpN0EyeOSpPNZ0kqGS185Ys/4k0wGf4B9eaLtAQIe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qDjhr6Xj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Th+YM87S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzuaDLJwwVysIyAdOCro+9gtoWbupxRepvKTtxWGNrM=;
	b=qDjhr6XjwQmAj4bAwa1deLiOSvMTRvX+eTiE4ckuxnfk0ndSLkddncu15NbHeoJXLIzfvk
	ZqJdfQyrw72fXQdL4i5Xl1J0tbiL77ihlmuMcqZRMtiSIGV4TDQ4HUek3y2sIbVZROf6rF
	8sdwvo+8EejsmcE2U5D/etA/toFVpaBCfF73nqzt4fAaa5j2J6wzc4Qxv0rWRRk8y1EBdd
	TYMfUChFVI+niFpSNJ6tVXmkXw1gKU+9vBE+oLI3DTx4VCbK+1QFuP8bKhYcwQDqrl3YIK
	RS3qQn6dQJAS7uWXAFtuqX14igTDlnPFh3tBG8wjqdaiR08B5HrcUzE5h0kRUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537615;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzuaDLJwwVysIyAdOCro+9gtoWbupxRepvKTtxWGNrM=;
	b=Th+YM87SpmjzxKrvZ3TqcBWQjmTqlFHNMJgEWbNII/1PrLN51z/XsXKx1qRvJbufBdIv7c
	s+srYIAJsfXAAtDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] Documentation: irq-domain.rst: Simple improvements
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-56-jirislaby@kernel.org>
References: <20250319092951.37667-56-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653761428.406.8803786696017286023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     3701ae11de5fdcde0d129a7083032c8d87fd7e04
Gitweb:        https://git.kernel.org/tip/3701ae11de5fdcde0d129a7083032c8d87fd7e04
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:09 +02:00

Documentation: irq-domain.rst: Simple improvements

The improvements include:

  * Capitals in headlines.
  * Add commas: for easier reading, it is always desired to add commas
    at some places in text. Like before adverbs or after fronted
    sentences.
  * 3rd person -> add 's' to verbs.
  * End some sentences with period and start a new one. Avoid thus heavy
    sentences.

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-56-jirislaby@kernel.org

---
 Documentation/core-api/irq/irq-domain.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index c365c3e..cb25649 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -1,19 +1,19 @@
 ===============================================
-The irq_domain interrupt number mapping library
+The irq_domain Interrupt Number Mapping Library
 ===============================================
 
 The current design of the Linux kernel uses a single large number
 space where each separate IRQ source is assigned a different number.
 This is simple when there is only one interrupt controller, but in
-systems with multiple interrupt controllers the kernel must ensure
+systems with multiple interrupt controllers, the kernel must ensure
 that each one gets assigned non-overlapping allocations of Linux
 IRQ numbers.
 
 The number of interrupt controllers registered as unique irqchips
-show a rising tendency: for example subdrivers of different kinds
+shows a rising tendency. For example, subdrivers of different kinds
 such as GPIO controllers avoid reimplementing identical callback
 mechanisms as the IRQ core system by modelling their interrupt
-handlers as irqchips, i.e. in effect cascading interrupt controllers.
+handlers as irqchips. I.e. in effect cascading interrupt controllers.
 
 Here the interrupt number loose all kind of correspondence to
 hardware interrupt numbers: whereas in the past, IRQ numbers could
@@ -21,15 +21,15 @@ be chosen so they matched the hardware IRQ line into the root
 interrupt controller (i.e. the component actually fireing the
 interrupt line to the CPU) nowadays this number is just a number.
 
-For this reason we need a mechanism to separate controller-local
-interrupt numbers, called hardware irq's, from Linux IRQ numbers.
+For this reason, we need a mechanism to separate controller-local
+interrupt numbers, called hardware IRQs, from Linux IRQ numbers.
 
 The irq_alloc_desc*() and irq_free_desc*() APIs provide allocation of
 irq numbers, but they don't provide any support for reverse mapping of
 the controller-local IRQ (hwirq) number into the Linux IRQ number
 space.
 
-The irq_domain library adds mapping between hwirq and IRQ numbers on
+The irq_domain library adds a mapping between hwirq and IRQ numbers on
 top of the irq_alloc_desc*() API.  An irq_domain to manage mapping is
 preferred over interrupt controller drivers open coding their own
 reverse mapping scheme.
@@ -38,7 +38,7 @@ irq_domain also implements translation from an abstract irq_fwspec
 structure to hwirq numbers (Device Tree and ACPI GSI so far), and can
 be easily extended to support other IRQ topology data sources.
 
-irq_domain usage
+irq_domain Usage
 ================
 
 An interrupt controller driver creates and registers an irq_domain by
@@ -76,7 +76,7 @@ If the driver has the Linux IRQ number or the irq_data pointer, and
 needs to know the associated hwirq number (such as in the irq_chip
 callbacks) then it can be directly obtained from irq_data->hwirq.
 
-Types of irq_domain mappings
+Types of irq_domain Mappings
 ============================
 
 There are several mechanisms available for reverse mapping from hwirq
@@ -101,7 +101,7 @@ map are fixed time lookup for IRQ numbers, and irq_descs are only
 allocated for in-use IRQs.  The disadvantage is that the table must be
 as large as the largest possible hwirq number.
 
-The majority of drivers should use the linear map.
+The majority of drivers should use the Linear map.
 
 Tree
 ----
@@ -189,7 +189,7 @@ that the driver using the simple domain call irq_create_mapping()
 before any irq_find_mapping() since the latter will actually work
 for the static IRQ assignment case.
 
-Hierarchy IRQ domain
+Hierarchy IRQ Domain
 --------------------
 
 On some architectures, there may be multiple interrupt controllers

