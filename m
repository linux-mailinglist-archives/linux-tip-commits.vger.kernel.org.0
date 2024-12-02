Return-Path: <linux-tip-commits+bounces-2934-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E39E002B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2900A2812B4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248DF1FC7FC;
	Mon,  2 Dec 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IRordY04";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pX2OgvsM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEA1F8F16;
	Mon,  2 Dec 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138122; cv=none; b=ZsJFj+LuIXqW1Jz2iwBdNOnhssVHGx9DcXwXOWkB/5GBprhw23/UU13/dr1QrxtKFKBZhd9zt+W6FtR4rZXf8RF9tyl1DV7GBfyl2TJQR83htLWyjf4bgUSZ3F4zt+re8rNdKmASnvnY9cFG+zR+gdttPfbXeO2X2YmQzJbtQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138122; c=relaxed/simple;
	bh=O7l0allGsbxHqkHGPBRB+7uvD+HSqnEyPOApblgtl44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tfrV/0ZpcZJ2kGveq2ymdRr7zHUFbWfXzzCB5kj6A8N7+agI6wVI/qalch1F0uUO3zk74XR6ibzcJaLEHc4YQCJi+ku1XLVnV0cs3M4QRTC4u2P6qYHoka8jFspsj+ZkRDosxF+bIKBz/bXG9sKNd0bsLMC2wkM+zgmUEBu0/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IRordY04; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pX2OgvsM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4FMqBGFVFIgGYy5JaU3O25F2od/vp/S/bBG62wFtmM=;
	b=IRordY048yIV0n580tj+EhjfhmK6VPS1nU42DfgRYfsvpjwKhr9OXocK00DdsTJh3jbAe+
	uvxheZI6ZupG1ipnPZcBpHHd6tVAaUWDW6pWnc6W5MyjDNiC8mp8Iz5+w5c58OGW7UFRWD
	3svCQYgw2H/45VjEzuw9UoblcZrGSPXk3Pn6tf6JZDw4I/1Pv+yb4ox8ajeSrz6nHlfAwu
	uH7YGQavvJBRlEay74ymyRZO2s5gtkWehTsJGAdAGjfbOu9raUMdxetUKaLhoagU7ORLGm
	LYnU5znuH2Egdmt5sG5sDEWO2ZNxmwyaAjy98IH4O6FayAPSWyaN+BqqadnC8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4FMqBGFVFIgGYy5JaU3O25F2od/vp/S/bBG62wFtmM=;
	b=pX2OgvsM2Qc3nDgJiI5QKzimT8ZgnNaPED7RDv/bpo6BqFcfluhT/pKl5a8qyFoohuFb08
	LuXxDrKlQCGyWmCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Warn about unknown annotation types
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094312.611961175@infradead.org>
References: <20241128094312.611961175@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313811810.412.12363821762248202483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e7e0eb53c2f0f68fe2577472ce2802a4efd9d7ce
Gitweb:        https://git.kernel.org/tip/e7e0eb53c2f0f68fe2577472ce2802a4efd9d7ce
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:39:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:45 +01:00

objtool: Warn about unknown annotation types

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094312.611961175@infradead.org
---
 tools/objtool/check.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 26bdd3e..bfb407f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2335,6 +2335,10 @@ static int __annotate_ifc(struct objtool_file *file, int type, struct instructio
 static int __annotate_late(struct objtool_file *file, int type, struct instruction *insn)
 {
 	switch (type) {
+	case ANNOTYPE_NOENDBR:
+		/* early */
+		break;
+
 	case ANNOTYPE_RETPOLINE_SAFE:
 		if (insn->type != INSN_JUMP_DYNAMIC &&
 		    insn->type != INSN_CALL_DYNAMIC &&
@@ -2359,11 +2363,20 @@ static int __annotate_late(struct objtool_file *file, int type, struct instructi
 		insn->unret = 1;
 		break;
 
+	case ANNOTYPE_IGNORE_ALTS:
+		/* early */
+		break;
+
+	case ANNOTYPE_INTRA_FUNCTION_CALL:
+		/* ifc */
+		break;
+
 	case ANNOTYPE_REACHABLE:
 		insn->dead_end = false;
 		break;
 
 	default:
+		WARN_INSN(insn, "Unknown annotation type: %d", type);
 		break;
 	}
 

