Return-Path: <linux-tip-commits+bounces-3347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F9A2D6BA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Feb 2025 15:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7C63A946C
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Feb 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E5248183;
	Sat,  8 Feb 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qisjkvfh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a4sInTLv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C81991BF;
	Sat,  8 Feb 2025 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739026324; cv=none; b=q/JMQElkXrMdAdEYxjQDYmBqOIyY/PoxZFwfP4ON9UFU7aVsUfjMjg6cGCZrC4rkDA+kTcLZIXRWWEe+sscjr3xT0l1QmTRaa/cVG2IMG89dZ34s04Ra9Yy9dryTUcNoOyAGPgb+BOzvX7dtIaQebI/S0nC2ka/n/XN/+hqSsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739026324; c=relaxed/simple;
	bh=UvjQAWMzZ7PDuyFzfTHDVhbhLPNekUkCmXqB7WBLOWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nGLlQowaIS5XoMsQtAlNKtMznW1SxmjzM4m77kRStyyW1PvUYO3Npa0gO6HGdEHHkLIp2S7A+A2HQsUaR6wFWyU6iEKcygPp+ItZTYFayMCvytG5kVX4uUBnTNpw4+5t9h73tX1UmRZxA9S2a1qkU8QThRRjkoFHtkRa0ExK37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qisjkvfh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a4sInTLv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Feb 2025 14:51:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739026320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCkk6YiRsuSHxYAEBF3axawsK/w8BCeVyObkcrvqNnU=;
	b=qisjkvfh5+vZtYFknqeQowojDobgH5yYLTpem00GeY0OIoQsjo5MzJCmttjHrqyXSro977
	dqQy0Y/nQDLmK/oDQTphdYvW4uRSP1xllW8hKFkODbAFhtWEmMdJ2IeGKG4v9Ez5rLcybl
	pjfGVqkZlfnIdXjD9ztTkAIJEmQ+rHu87K8osceMFbdXJKGRx3xM1aBCi2/ISUSLmRersk
	LX/lvMEXRNkcair/TQUm/6hmJulzW5v22OYIRiDZk/qMFMTIjTOgh2joHFH/GhX+L/a/7I
	ieXqy1IzjPU95mq+68L6EzjzrcabTMUd+IDWjsKxhf3pdN1K08qxSWMwzd68Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739026320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCkk6YiRsuSHxYAEBF3axawsK/w8BCeVyObkcrvqNnU=;
	b=a4sInTLvBDNnRz6QZsvPx7IvKlGXCLm/7bgqVRgx+lUPDResrH1UQyWvr9Dp3iK+6HCkBv
	D3blay7bTOgiOnDA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Ignore dangling jump table entries
Cc: Klaus Kusche <klaus.kusche@computerix.info>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <ee25c0b7e80113e950bd1d4c208b671d35774ff4.1736891751.git.jpoimboe@kernel.org>
References:
 <ee25c0b7e80113e950bd1d4c208b671d35774ff4.1736891751.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173902631974.10177.18265129202576943581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     3724062ca2b1364f02cf44dbea1a552227844ad1
Gitweb:        https://git.kernel.org/tip/3724062ca2b1364f02cf44dbea1a552227844ad1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 14 Jan 2025 13:57:58 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 08 Feb 2025 15:43:08 +01:00

objtool: Ignore dangling jump table entries

Clang sometimes leaves dangling unused jump table entries which point to
the end of the function.  Ignore them.

Closes: https://lore.kernel.org/20250113235835.vqgvb7cdspksy5dn@jpoimboe
Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/ee25c0b7e80113e950bd1d4c208b671d35774ff4.1736891751.git.jpoimboe@kernel.org
---
 tools/objtool/check.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 753dbc4..3520a45 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1975,6 +1975,14 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		    reloc_addend(reloc) == pfunc->offset)
 			break;
 
+		/*
+		 * Clang sometimes leaves dangling unused jump table entries
+		 * which point to the end of the function.  Ignore them.
+		 */
+		if (reloc->sym->sec == pfunc->sec &&
+		    reloc_addend(reloc) == pfunc->offset + pfunc->len)
+			goto next;
+
 		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!dest_insn)
 			break;
@@ -1992,6 +2000,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		alt->insn = dest_insn;
 		alt->next = insn->alts;
 		insn->alts = alt;
+next:
 		prev_offset = reloc_offset(reloc);
 	}
 

