Return-Path: <linux-tip-commits+bounces-1937-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0898947ABB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC9428163F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C801586C4;
	Mon,  5 Aug 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tFdR2ioS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFkEmu5L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23398156F36;
	Mon,  5 Aug 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858969; cv=none; b=CcIhTYtp8b8IO6xKY10lHSrdBywWBTqN8ggVquoiaGt7crrBQZd2vucKNHSf+pS/3MA+Fo2hMIDccccsq1qbVGJpWElvU7yEfcg9oqr5JE7mgJsdw4UkaDcQVVkgUxBVlsNeHwRcTWHHVXl0LR7a0B3Yp1o53bNDb3loR4ROM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858969; c=relaxed/simple;
	bh=xjoFrpUlKVAE9wqZBNuDZBnZdA/MuH4mD9rf2nMuDc0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DiM/LKDreyy5eEF9lkzBbXWJJUT6rKdDEJKkJvJfXXvk4g7k0RS8xT7A0IRHEfrrklaokYkY3RCGWWFGdrrJGpe917fILkxaWkVVwok81HUCO3ahA1yg0fvpyhXfrhlbDKvakHHreVmNyh3n96SUSWA5BYeXxiv/04AR6TSdpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tFdR2ioS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFkEmu5L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vG+PYDMKw/jCwnKzB5WZq+FWh+VZRPqVvhOsoJ5V0Q4=;
	b=tFdR2ioSQtrkGATcf6TYNn+eMCIK1zUM1jshuRQN7P+m4NE3+qyRO2zcv2QNQtypATPfMz
	bRC2EXXzhYwT9YpHG39hOiH0YA3w6z5IiL/84cJy1IK1XFCooaX0x66gOHEssyA7O8bqwO
	6HtHFl7hZdU7zvkW0wB/cg/i9AaG8gUuvZIIuXVZ0Ph/pErn3NHYGy4KWyWOjwFmDb+ofs
	8I+2/TYXPNAyTVIngANJVYBfeJQPcUEKBxmcuk02ESBxSLZ1o0SegB66+3tFEj3p9xRfCH
	UrDlnh2pRvODma3eZYGEg8RHI00crbq487OOT3RhjPpcoROKyyqIXlR2JYgv/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vG+PYDMKw/jCwnKzB5WZq+FWh+VZRPqVvhOsoJ5V0Q4=;
	b=qFkEmu5LA7o6Qe/0PlX1cgO2f2iyTEaX5tu9YIgmR7QZ+McrNuITz+t3btuPY/nW1DQHoF
	LORuQy7LygEu5iCA==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: simplify error handling for alloc_uprobe()
Cc: Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240801132719.GA8788@redhat.com>
References: <20240801132719.GA8788@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896501.2215.72648014861106086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7c2bae2d9c27a89280b63ff3567d2dac2d89db28
Gitweb:        https://git.kernel.org/tip/7c2bae2d9c27a89280b63ff3567d2dac2d89db28
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 01 Aug 2024 15:27:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:31 +02:00

uprobes: simplify error handling for alloc_uprobe()

Return -ENOMEM instead of NULL, which makes caller's error handling just
a touch simpler.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20240801132719.GA8788@redhat.com
---
 kernel/events/uprobes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 698bb22..e9b092a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -725,7 +725,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 
 	uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
 	if (!uprobe)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	uprobe->inode = inode;
 	uprobe->offset = offset;
@@ -1167,8 +1167,6 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 
  retry:
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
-	if (!uprobe)
-		return -ENOMEM;
 	if (IS_ERR(uprobe))
 		return PTR_ERR(uprobe);
 

