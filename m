Return-Path: <linux-tip-commits+bounces-3617-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD85A44BE7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 21:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD6419C6C27
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC62AF1E;
	Tue, 25 Feb 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrxsIadv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G9iJ5ehF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84918C00B;
	Tue, 25 Feb 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513630; cv=none; b=MiWjx7exqOeK03O0oTukFawndJmYK8AMkijGI1bZ/Fk2cDj6JefSKRt3/eRfpUgdGwF6wBKP96vJlQ9FnU7/vD7IcNEAIDi0wezPH/l8uZvqjXD7WY6mRiE/rHLpbjAwwGG559yP5GH7sQKjMkJDqc9Tol8PVV+9xSC45gW+g/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513630; c=relaxed/simple;
	bh=ZzrWvEIaHxlHmcup9/3affT6YQvKwDz/DS2JNUOoxv4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TsPA+0CXuYYVJKJjaS96PwdQVhfrjJca920rFVqJcgvIqgDl3VeJv488rgSgt+IhliohrnSFsVcfNsGH0Hu25QKOshRzmmKKhXn4Fa8Amg9k+WSQgv6azSVeoPM+ST+mF6ibbm6p9ETapH8oP8bpp4PO6WFE5noV8x20MQWMEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrxsIadv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G9iJ5ehF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 20:00:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740513627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDvQx0iuZTPnj/RQPcbC4VWvwAWlQVDBqERz/cDMIeo=;
	b=LrxsIadvMKRzHupQfQAAY9mWPjeiUmSBZZugv00Z1cGxMC0ob+aL2iLR6zRb60nm16KZav
	QwqeGdy7D5QjFarN6ifi5fB/1xOn9h8dbbRRQDtZ2ec6AurQ6YQ8UA3Wp2wOHPOqodpBMU
	nDFh8WpXw48eM+9Le1TovB6BC+J//UbY9XzYTLTS4uAWjHzbag53i4nBYAfKaFmXiL1b1j
	2sYNliAMY8DcVwJL+eozOE6gvEWUjBEJeYGoR/9uOmAIw1jWLta7puan+oHEH/jKK3d/vl
	Lb+epcnwTWtVhXgWQahGiKE2GJNwxbaYxzYFrxcxuuUAjfKyiIn0SdrHmBQ/Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740513627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDvQx0iuZTPnj/RQPcbC4VWvwAWlQVDBqERz/cDMIeo=;
	b=G9iJ5ehFRW0BIYCtx5m5SmkMIdBZ6ovaD8irW5rk77+N4rav9NjQIyinUfqGGNhv34Ab2G
	NSu+77vIchmF2aCg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mtrr: Remove unnecessary strlen() in mtrr_write()
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250225131621.329699-2-thorsten.blum@linux.dev>
References: <20250225131621.329699-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174051362601.10177.9946583706077951040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8e8f0306497dea58fb4e8e2558949daae5eeac5c
Gitweb:        https://git.kernel.org/tip/8e8f0306497dea58fb4e8e2558949daae5eeac5c
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Tue, 25 Feb 2025 14:16:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 20:50:55 +01:00

x86/mtrr: Remove unnecessary strlen() in mtrr_write()

The local variable length already holds the string length after calling
strncpy_from_user(). Using another local variable linlen and calling
strlen() is therefore unnecessary and can be removed. Remove linlen
and strlen() and use length instead.

No change in functionality intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250225131621.329699-2-thorsten.blum@linux.dev
---
 arch/x86/kernel/cpu/mtrr/if.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index a5c506f..4049235 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -99,7 +99,6 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	char *ptr;
 	char line[LINE_SIZE];
 	int length;
-	size_t linelen;
 
 	memset(line, 0, LINE_SIZE);
 
@@ -108,9 +107,8 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	if (length < 0)
 		return length;
 
-	linelen = strlen(line);
-	ptr = line + linelen - 1;
-	if (linelen && *ptr == '\n')
+	ptr = line + length - 1;
+	if (length && *ptr == '\n')
 		*ptr = '\0';
 
 	if (!strncmp(line, "disable=", 8)) {

