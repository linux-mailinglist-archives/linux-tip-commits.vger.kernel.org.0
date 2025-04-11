Return-Path: <linux-tip-commits+bounces-4844-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FBBA858BA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED86B7AA7A7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F529DB68;
	Fri, 11 Apr 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrL0kBYv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d2w32jmi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416529CB30;
	Fri, 11 Apr 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365708; cv=none; b=LDQJryQwyq5TdSFFdwtQ1eMjB/3IVYhGXfhs5WlcsASQt7OVYzb2j5qYPlNYmG7aYOINycUTyk7LwnJc+1vuH+M1AmB+mQfrVlLeHbbbP49bYlVSbhpl5pSIBp7N1eEdxu2nN4ollyGJjoj2VxBzSFdVrRjph5IzLFM+LOfEN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365708; c=relaxed/simple;
	bh=1BF5JN6E4206BpgsawGbm7jRbwIKDsZz30DXtbvXufM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tcZpulG07spuUmz4R1bx+wHTeJy1j22Np3yGAQF2kSgYukPE+A8oKO4yAV3EnvhXkjFtddA97UwP8XKACbAS/pC2yFhc/PoAQB0alAE7uAKqX0oU6ePMDk8TnPAzaeYvD6GMmmwfd8j5eZPLQ3wT0U2UiQi7YiQNSYgG/FTfo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrL0kBYv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d2w32jmi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ4/KU8G1/Y5QAXX/mDhj1OTycS6qSzfWgFJSM5qPdg=;
	b=YrL0kBYvyOWzkt7+RJ9TogGWnvge4HDORkq2sQLqgPiwwF5nYy5znIdSpZQCmXV12iw/tg
	1BO6hac39739T4fjvtANWLP+EoDFIlvOn4dBDZzttXO4KgplUzRrhmhpziQTREKROt/Er+
	/nodwbBOXzKYgkfGwsdJhSBR4wGzSfcs53/qivcQ8FDlooWyraEL3nviiHIh6UJdvAxza2
	BnYPAa1ddLtdBcgcZkg1t5jR4QyTHch0RZubebTKL4f7L9EFyQZnBMTeCD1C2WuIgLpALn
	ZdBPZA5ECbrp9iwHP3EeXIirbF378yDJYe+riX5RQ2esNFhJ0n5EuZee43QpoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ4/KU8G1/Y5QAXX/mDhj1OTycS6qSzfWgFJSM5qPdg=;
	b=d2w32jmiiMnHAI02O2CX0BD9vxNv3ritdlWAxdB19nhp/VaqyPIDoQ3v6KXl2urZZdZifG
	VEo/vsZGLJCg51AA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Rename
 'TP_ARRAY_NR_ENTRIES_MAX' to 'TEXT_POKE_ARRAY_MAX'
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-46-mingo@kernel.org>
References: <20250411054105.2341982-46-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436570322.31282.14572126951630035584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     8036fbe5a5d618be3694c4719afb14fd14cc972d
Gitweb:        https://git.kernel.org/tip/8036fbe5a5d618be3694c4719afb14fd14cc972d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:35 +02:00

x86/alternatives: Rename 'TP_ARRAY_NR_ENTRIES_MAX' to 'TEXT_POKE_ARRAY_MAX'

Standardize on TEXT_POKE_ namespace for CPP constants too.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-46-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c5abcf9..4b460de 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2466,10 +2466,10 @@ struct smp_text_poke_loc {
 	u8 old;
 };
 
-#define TP_ARRAY_NR_ENTRIES_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
+#define TEXT_POKE_ARRAY_MAX (PAGE_SIZE / sizeof(struct smp_text_poke_loc))
 
 static struct smp_text_poke_array {
-	struct smp_text_poke_loc vec[TP_ARRAY_NR_ENTRIES_MAX];
+	struct smp_text_poke_loc vec[TEXT_POKE_ARRAY_MAX];
 	int nr_entries;
 } text_poke_array;
 
@@ -2863,7 +2863,7 @@ static void smp_text_poke_batch_flush(void *addr)
 {
 	lockdep_assert_held(&text_mutex);
 
-	if (text_poke_array.nr_entries == TP_ARRAY_NR_ENTRIES_MAX || !text_poke_addr_ordered(addr))
+	if (text_poke_array.nr_entries == TEXT_POKE_ARRAY_MAX || !text_poke_addr_ordered(addr))
 		smp_text_poke_batch_process();
 }
 

