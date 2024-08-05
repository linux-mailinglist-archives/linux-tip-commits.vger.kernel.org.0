Return-Path: <linux-tip-commits+bounces-1931-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C16947AB0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2AA1F2170B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C7156679;
	Mon,  5 Aug 2024 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScK/1fIw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oKpu7BSi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859AE155C88;
	Mon,  5 Aug 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858966; cv=none; b=KJfZU0P2zUzXr+oaiUvrJQwpduVcF7BLqc1VBfLsM64MO1TTdFQoPqW8KZ+ZyV1XxARqaKzsG4cDr2UmHnhd0CHlgzQvUf27wDRjCyJx+pN/4rsdtt1L4cUxt0AiW6s1L0BybphlmUxErhJpY7NTE5g6tobQADfq3KP8EnTlREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858966; c=relaxed/simple;
	bh=fhUAT+ubgGlJ7/s2SgbtRCvYlsWFb9c2HD0zoYX5yA8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W4kDsd2/Nw5WbCqeRem53aIhDKyEq8Cl4nMWQIU89PjMCNa8Di3zBzcxjRMeScaCGB1I/aeH97APBDA3+8YO3E4fMzMkbVddDYSOSZ4tS/iD0hFsi5nyPohALFzen0jnUVlyBJ4CpfMvJ53Dy7oW/r6OgLUj0WdhlG3ifLefteI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ScK/1fIw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oKpu7BSi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5rWvlb+cj1hNeoF73vS6KY3kYhF+kwXKDOrforTNMQ=;
	b=ScK/1fIwKujnV4xOoVXWmav6Y10aHcy+wi7NbRt9bBqrrc6GpNx+7NlkX030ooTPV8FxtS
	7paysaNVlnusbOUuh54U+ko+ME7gXf6Pcc7agl1HhWVXhXhXHLbgpG6Nix8+c8v4A6MMs/
	qmD7WQBKwVOsUuJkgOpfESIRO89gnieGhaQLlrKoBXVri+V0kTp4HXR7OfTJU3miuKElxi
	BKssJ33FbG+QHAD1RICHqGfapG3HCIM9SiHGOt5kiGSsIkinC/l/BU1TARMpd1drewrsE8
	p+TpD+DZi9Y9t9IubKXl1YL+/TUSyI9jJXIVojEB2W78l8EOU2rZelxLJ4A+5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858962;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5rWvlb+cj1hNeoF73vS6KY3kYhF+kwXKDOrforTNMQ=;
	b=oKpu7BSiLjnVNKCx80oSQL1wuE0vwPClCHwz4kOj9VheM1Lx4QBOpjm2sWHzY/7LtYZZn5
	Qn7giuQYHalVfvBA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: shift put_uprobe() from delete_uprobe() to
 uprobe_unregister()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240801132749.GA8817@redhat.com>
References: <20240801132749.GA8817@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896198.2215.3237383472248296210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     12026d2034dfeb575e0eb28f33431cbf03dc732c
Gitweb:        https://git.kernel.org/tip/12026d2034dfeb575e0eb28f33431cbf03dc732c
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 01 Aug 2024 15:27:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:32 +02:00

uprobes: shift put_uprobe() from delete_uprobe() to uprobe_unregister()

Kill the extra get_uprobe() + put_uprobe() in uprobe_unregister() and
move the possibly final put_uprobe() from delete_uprobe() to its only
caller, uprobe_unregister().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20240801132749.GA8817@redhat.com
---
 kernel/events/uprobes.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 175058b..30348f1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -939,7 +939,6 @@ static void delete_uprobe(struct uprobe *uprobe)
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
 	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
-	put_uprobe(uprobe);
 }
 
 struct map_info {
@@ -1094,7 +1093,6 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	int err;
 
-	get_uprobe(uprobe);
 	down_write(&uprobe->register_rwsem);
 	if (WARN_ON(!consumer_del(uprobe, uc)))
 		err = -ENOENT;
@@ -1102,10 +1100,16 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 		err = register_for_each_vma(uprobe, NULL);
 
 	/* TODO : cant unregister? schedule a worker thread */
-	if (!err && !uprobe->consumers)
-		delete_uprobe(uprobe);
+	if (!err) {
+		if (!uprobe->consumers)
+			delete_uprobe(uprobe);
+		else
+			err = -EBUSY;
+	}
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
+
+	if (!err)
+		put_uprobe(uprobe);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 

