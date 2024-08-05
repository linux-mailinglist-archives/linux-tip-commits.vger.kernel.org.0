Return-Path: <linux-tip-commits+bounces-1934-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1447947AB4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B8D1F22188
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87D4156993;
	Mon,  5 Aug 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kE8lj1yI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PnnZFoGX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596815575D;
	Mon,  5 Aug 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858967; cv=none; b=LSfluVzpIfcHbDofb/+UTaPYOO+gKrw53EjQLzuomPDu4bSZ7RlG9u60YDthGgb4tGzKQD5n0TtacBTn2Wx+rAdMzoxRMFE0JZlTZc9uOlF00AWtzLtCadYSVgKZDHIN9JviOZOw84p8l+fkIvnj3bDXbNQJq1DxhQ417icu5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858967; c=relaxed/simple;
	bh=YZ3/FXCkwzBmv/nO9aX2QrE+XkiBbv5VZQ6rZK+PhLs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g06GUZpKtB7XuYetzfEb8bzCkFSD/Zk97p1bDj/4WRxLiUrffRCRfamwXTqcV2V/9fs0LVOwvYQVP5UnzzcQKt/42wyx2F19lXtqYjC/Jen/5T7tZWVDRj4qlFAlrXC5/bf8fFXxUrNAm8QPr4YgdgThg13k7UVfEOUPC1IQFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kE8lj1yI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PnnZFoGX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i13cPpjkJVnKsyzLpiIOEzvc7QcaaWBlZrU/iSXxbEc=;
	b=kE8lj1yINTiJRqdEzgUpJAq6rcqFbW03pY9pqMbJ0Wq7vQIyDYlP1pk97RQy2PdH3wIPvv
	1VgL43CEVg+Td0FdFM2jvJDf5YWjmOBPgbuiyjKt3tQsUy09bQtEhfZQz99P8RNnW69Ivu
	/DnWK411NlLGU3q731VPSPrsFbbtPyxv5KDdx0zK1RUkPJCynEU+ErZETiuz1wklQbF3jA
	w06/Sh7vfgRFfDVS37GoE1G9ohtjsi8JPO4Qa3BzbJ85I1OXitsxyyifKYIUikFLtFgnOo
	Hp3JFGMhPHcmS+5hH9D0ptLm4mKWoh1Uev0M5XSnK807efKIYuVPEf/Onb7T3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i13cPpjkJVnKsyzLpiIOEzvc7QcaaWBlZrU/iSXxbEc=;
	b=PnnZFoGXfijNjXe6sNB2h9vjoulzcECetbEyzKgmEFrPmyDcH686du19/JCgv+6XXaNOP4
	Nt/k6fMMW1fkJcAg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: fold __uprobe_unregister() into uprobe_unregister()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240801132744.GA8814@redhat.com>
References: <20240801132744.GA8814@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896262.2215.6938257232093000341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     70408bebba94a63ea11471ed00168cd8606a9328
Gitweb:        https://git.kernel.org/tip/70408bebba94a63ea11471ed00168cd8606a9328
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 01 Aug 2024 15:27:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:32 +02:00

uprobes: fold __uprobe_unregister() into uprobe_unregister()

Fold __uprobe_unregister() into its single caller, uprobe_unregister().
A separate patch to simplify the next change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20240801132744.GA8814@redhat.com
---
 kernel/events/uprobes.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index eacf287..175058b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1085,20 +1085,6 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	return err;
 }
 
-static void
-__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
-{
-	int err;
-
-	if (WARN_ON(!consumer_del(uprobe, uc)))
-		return;
-
-	err = register_for_each_vma(uprobe, NULL);
-	/* TODO : cant unregister? schedule a worker thread */
-	if (!uprobe->consumers && !err)
-		delete_uprobe(uprobe);
-}
-
 /**
  * uprobe_unregister - unregister an already registered probe.
  * @uprobe: uprobe to remove
@@ -1106,9 +1092,18 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
  */
 void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
+	int err;
+
 	get_uprobe(uprobe);
 	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
+	if (WARN_ON(!consumer_del(uprobe, uc)))
+		err = -ENOENT;
+	else
+		err = register_for_each_vma(uprobe, NULL);
+
+	/* TODO : cant unregister? schedule a worker thread */
+	if (!err && !uprobe->consumers)
+		delete_uprobe(uprobe);
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 }

