Return-Path: <linux-tip-commits+bounces-4884-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2433A85928
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4889C07E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF929B22D;
	Fri, 11 Apr 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGOCTqBK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ah8nIu8h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6B24DC41;
	Fri, 11 Apr 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365745; cv=none; b=g1sDG7zqAHolubxe1DaZIoqpu/471l4PdFnIlowuuljgUR8jc45XcyovRnh9Qpr4EB+g93vMIla7WfxFyn0+AkzkuEMFlEumE4DlQk7LMXiUCvtVe0j+SgliOsrmn2mCizTZPQ4mzHamXll3h0MUDr3bmoxg3L/FSPbVW6ahtB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365745; c=relaxed/simple;
	bh=2VYdbjnIZHEwc7T29T6nCUKAp2Gk7FQJZi0RA3rC8Nw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZbFdzWAYP/1aJ/WfkkVQ69k+K1MyK/18/72QiC91Qo8iEBqq1Xjrbce1UJD2jxyZY8DFKTOg/jIesU4fVFr5fwMET0qjN0SdEXxNiCWOWUcXzJ+kCnsdtD8Fn/mZcON7csRcpkBhBk+15a/PlpR60FRNQCB5O+bvkb+N8A3i5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGOCTqBK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ah8nIu8h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V92K6yi/QYkwueENPyyrnkMqI4EdEpVXZNZwGFNC2g=;
	b=ZGOCTqBKkjaZ8+85NYAJ/rXRp5+t7V1TAAKqyEphgA7H9VP270TioBckXDXeLb5gb1vYje
	YYLik9Ld7Dj4m4KCsh5a2ku28Y2g9+w+9X1kyL7Pi0uTWsGh65vt8m75hJOQaVlGR/kvLA
	CFwut5cnEl4J75DO4RufSbqOTDQ6Aul7AmQ+UWKVOua3cviSPoMHpmfceGRnfqp8MOGZjS
	506bC1zs2FrM2+vNm9+gwTd3cezLYjzG3tD/WMxsDVHPu6gOdYvyLepWPbYa3XgtPezhHq
	apEIzKjE2hAAiKhElW9Pjltj9/BwC248hwqD9gHKXn7qcegPJmgUerXKoGV5SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365741;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V92K6yi/QYkwueENPyyrnkMqI4EdEpVXZNZwGFNC2g=;
	b=ah8nIu8hCjSsg9/m7xcCG+a7kN6z4M0VM0wxyHjdWZMe5RrlLL0D5L8l1GfXPLJeiQtflE
	1RekHa/qkJKnpmDg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename 'struct
 bp_patching_desc' to 'struct text_poke_int3_vec'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-4-mingo@kernel.org>
References: <20250411054105.2341982-4-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436574070.31282.7865255954237542519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     84e5ba949b0a3fcf2fd0a1b6c9ce14d8436dbbb8
Gitweb:        https://git.kernel.org/tip/84e5ba949b0a3fcf2fd0a1b6c9ce14d8436dbbb8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Rename 'struct bp_patching_desc' to 'struct text_poke_int3_vec'

Follow the INT3 text-poking nomenclature, and also adopt the
'vector' name for the entire object, instead of the rather
opaque 'descriptor' naming.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-4-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5f44814..8edf7d3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2471,17 +2471,17 @@ struct text_poke_loc {
 	u8 old;
 };
 
-struct bp_patching_desc {
+struct text_poke_int3_vec {
 	struct text_poke_loc *vec;
 	int nr_entries;
 };
 
 static DEFINE_PER_CPU(atomic_t, bp_refs);
 
-static struct bp_patching_desc bp_desc;
+static struct text_poke_int3_vec bp_desc;
 
 static __always_inline
-struct bp_patching_desc *try_get_desc(void)
+struct text_poke_int3_vec *try_get_desc(void)
 {
 	atomic_t *refs = this_cpu_ptr(&bp_refs);
 
@@ -2517,7 +2517,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 
 noinstr int poke_int3_handler(struct pt_regs *regs)
 {
-	struct bp_patching_desc *desc;
+	struct text_poke_int3_vec *desc;
 	struct text_poke_loc *tp;
 	int ret = 0;
 	void *ip;

