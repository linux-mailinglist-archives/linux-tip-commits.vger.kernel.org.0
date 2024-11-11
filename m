Return-Path: <linux-tip-commits+bounces-2833-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D89C3C86
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 11:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346FC1F21480
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6138175D54;
	Mon, 11 Nov 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P8WMZ7b/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Xpzfxpj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1D16EBED;
	Mon, 11 Nov 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322722; cv=none; b=HU9tBGxgTs/DiNTsWviU4NX42MCB5ErfFxzzeqpzzhGB3cdmYvqgVvKne5FcppHi9WGBIUHUkgKXGaBu5TXCWdBXpZEguY0iXWy/ubrrCk74EMTsIi0454uvn67HmhvaTSgSmj84Vq6Qxi4anKN2WJ6E78hM+w4/CgYA6ePtwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322722; c=relaxed/simple;
	bh=+1rdl4kViMbcr1qTWtTGv6ISc/UyDLqskzLcNFl1LGU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ij20uvr+mY9VRDMGvzpiA+crnY4btDa0zS32P4xC7WvVDPdXvjVg7hPBJmDuATckH8zaqtSrQGPV8ytCv9bzBuST5y+BComO/9r1oixGS7WAipVQ5+YEU13mW8R4hZjscOYaOh+TSYZqWe5UVzrergRKtDaZJXUn81lbRUIyM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P8WMZ7b/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Xpzfxpj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 10:58:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731322719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAfxbb6S/OelyM4O/wLwPOtIdhnKDFlz7L9eSAiY6ao=;
	b=P8WMZ7b/AtntoLYh51X+pRLT3anzRGwYXNKP5KIfbtEV7YGRLE4dm1uJIbnfoNRyPj8aqY
	LfeloQA4wS9UK8Tvd7fUuf6cTPjMfSL6q1BNhy5tmAyKp/FGhncLGSvRNT7YQ1bNcfHQiE
	vlX9sASmYW4zodUE589paApgEEJqKK7+g3lVzvrNTfDijlOaNlIZELnLBGUGXeMOKoOhOk
	Sd+37oARfYac5GZHVImVGrZVxFvrmIB+i2DX9npBOyKid4nBOeS42GQtr4YKZtn/1J9gTz
	e2vwAft/WLE8892k6jfGTaGP3gGO8PL6GALayfY5cN2Adq7a4eXr02yEHwvmXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731322719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAfxbb6S/OelyM4O/wLwPOtIdhnKDFlz7L9eSAiY6ao=;
	b=7XpzfxpjsbtecrtQvVEpZQOrH7nu3/RKluSRapAulfHVt6N9GZ91bKRz/liUPHjMDIVAe+
	odh83+we42kOzdBA==
From: "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: Re-order struct uprobe_task to save some space
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca9f541d0cedf421f765c77a1fb93d6a979778a88=2E17304?=
 =?utf-8?q?95562=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Ca9f541d0cedf421f765c77a1fb93d6a979778a88=2E173049?=
 =?utf-8?q?5562=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173132271895.32228.6361011101134876966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c554aa9ca976480839af342204e05bb4ce8367d5
Gitweb:        https://git.kernel.org/tip/c554aa9ca976480839af342204e05bb4ce8367d5
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Fri, 01 Nov 2024 22:13:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 11 Nov 2024 11:49:48 +01:00

uprobes: Re-order struct uprobe_task to save some space

On x86_64, with allmodconfig, struct uprobe_task is 72 bytes long, with a
hole and some padding.

	/* size: 72, cachelines: 2, members: 7 */
	/* sum members: 64, holes: 1, sum holes: 4 */
	/* padding: 4 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
	/* last cacheline: 8 bytes */

Reorder the structure to fill the hole and avoid the padding.

This way, the whole structure fits in a single cacheline and some memory is
saved when it is allocated.

	/* size: 64, cachelines: 1, members: 7 */
	/* forced alignments: 1 */

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/a9f541d0cedf421f765c77a1fb93d6a979778a88.1730495562.git.christophe.jaillet@wanadoo.fr
---
 include/linux/uprobes.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 7a051b5..e0a4c20 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -121,6 +121,9 @@ struct hprobe {
 struct uprobe_task {
 	enum uprobe_task_state		state;
 
+	unsigned int			depth;
+	struct return_instance		*return_instances;
+
 	union {
 		struct {
 			struct arch_uprobe_task	autask;
@@ -138,9 +141,6 @@ struct uprobe_task {
 	unsigned long			xol_vaddr;
 
 	struct arch_uprobe              *auprobe;
-
-	struct return_instance		*return_instances;
-	unsigned int			depth;
 };
 
 struct return_consumer {

