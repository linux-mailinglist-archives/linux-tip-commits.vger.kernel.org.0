Return-Path: <linux-tip-commits+bounces-2897-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BEC9DFFE3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B46160E6B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738F1FDE2A;
	Mon,  2 Dec 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RPRtQBZv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLKlWdB0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3D1FDE1B;
	Mon,  2 Dec 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138053; cv=none; b=U2C218gp/LdA1g4Hd1o6/Z5uuqjczlSFb7PnI/4Zv+CHclZ0znh/jDpKanW7jzwr6GlgzFVaFMvxqwqzAcWy1Gegk6NL23zvaakP0qIqzo10fCIUylnHX5iahaS8XlLIYemWKNV13Sj7YWtFvWKgqkVFrgXeMCpmOvhWKtvLXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138053; c=relaxed/simple;
	bh=8srJQlQRnd3uBczTrcDS0n3JCdopqvZNtz2OST9dtIA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OeCwT2W0S1NGLLyeqgVLBtD9BhzuAvcAU9TiXboKfePaMNcFKOLHGjKkUQT2JuQGZDW8Yb1pKQR+5VV2uhkpuZL4I9cgCbNFWjg01r+tsnoDQzeFgRSqjUfJ1nV3Y4wgY4ft8EYVc86iGgojhnqQ4Mduq3vsrtTgIzYNQrQRYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RPRtQBZv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLKlWdB0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTCXdQPkynqH9FhWSXWzfjxZVw96RFN0+E5pqyCgJSg=;
	b=RPRtQBZvvWKcvXv6LBDFoxKTvSbkNRqirIYpWGLA93J6aPpvjfWzHUKpZYUtHbWnHD4fMU
	nGLAdWlh7ybnsHdvhLVnJEfICmbwgha4JXVF2pZf+ym+dW7jHpBBwLIPnvXnYgmonUStAd
	s+t19rkOoYkLkkcke5lrPTyl9WsyO5u2i8zyLh/tURTdBJ4gD4WKT9ecQfwkDeXTdVXuS6
	y5PlIgKUXYADkOD4mNQbYBWFDDeQy8fJqQM2WKstuAzL0h3rSSfp51wySTbZ67SlvADLJE
	qBnuGDymjEoIlsOAlM3vNBnIvMpZEG0AiLWJw0ole8EOQ68y5bt/O61tcxnLoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTCXdQPkynqH9FhWSXWzfjxZVw96RFN0+E5pqyCgJSg=;
	b=NLKlWdB0fP6W0SmjJnCxGwyKlDdr1mISdBimdh8Re4QxYtDbzwCX8gX06+pwNjjk3y6Ub0
	KwXIjwTucyNl6jBQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: simplify find_active_uprobe_rcu() VMA checks
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241122035922.3321100-2-andrii@kernel.org>
References: <20241122035922.3321100-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313804898.412.14244739462302123654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     83e3dc9a5d4d7402adb24090a77327245d593129
Gitweb:        https://git.kernel.org/tip/83e3dc9a5d4d7402adb24090a77327245d593129
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 21 Nov 2024 19:59:21 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:38 +01:00

uprobes: simplify find_active_uprobe_rcu() VMA checks

At the point where find_active_uprobe_rcu() is used we know that VMA in
question has triggered software breakpoint, so we don't need to validate
vma->vm_flags. Keep only vma->vm_file NULL check.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lkml.kernel.org/r/20241122035922.3321100-2-andrii@kernel.org
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index fa04b14..62c14df 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2304,7 +2304,7 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, bp_vaddr);
 	if (vma) {
-		if (valid_vma(vma, false)) {
+		if (vma->vm_file) {
 			struct inode *inode = file_inode(vma->vm_file);
 			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
 

