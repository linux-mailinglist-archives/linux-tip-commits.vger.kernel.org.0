Return-Path: <linux-tip-commits+bounces-2216-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F66972079
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2F01C237DA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B1E17B4F9;
	Mon,  9 Sep 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0mm6jS+g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6qMKj825"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D3175D3F;
	Mon,  9 Sep 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902865; cv=none; b=qruaNS3yQRGZdqAUNfbjSZ5qh9G6qpakJmmjQ/SEf8v87VTPKgPWV5Kj8gFK+t2aKB9849XHX/oyoJmV+OeJrR5JzEJM3sw54ZaoV0pmtl3bnUqtJ8aN8exSaljr9U9ehQTMgWL2x3e8nleqfvTH/SIoQiRAlq4sKXCKkvd01is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902865; c=relaxed/simple;
	bh=cU0Gn9sCPhn27DhSoQtW5t8gUKA6yyviDF+JUxv2v+I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uw0H9kFlnI64QYBiGLlvMj0rjiuIg6WkFI86GbgMb6JsVE069asjSj/9oE5KuOV/YBNNfzy2wmsuFhC1AkvGonBrGK1nUR3fHjyHuVngUqq1uXWDFKY+TQ3AkdileXRft00w3ZG1X//kCNO54NXFbgIgbH7ObfPB898QNOVgzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0mm6jS+g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6qMKj825; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtRAPQichhKi1fZ8OzdFVSxK1lYL64dAR8OYMwUFOnM=;
	b=0mm6jS+g203oKebEGYO9q3QTTCeHTIhCm3OVn2xMxLUC2T96SQbjJunc9vpG4MHpLmda2Q
	vybnSQOiJIJwUBeByxrbvshk6punU8TXHKiBQhHZg9k2II6HkeOSMaZFrLmqW6Hf7pkFRp
	m15Lfllrp1zFIVi/qb3UE7YIjulh8x1zL2exi8uTNhQezXTtEwK7JyFFqoWTPUBzHIBnhZ
	5RRWp57oDXpiCcLq+9gJgdxlRju7N+Ar48hm//MvtBOX8Bj8ZNcglHLJxeyCQjuzPzenwQ
	3R67xKHEyS83mpsDi+EGs6pKBnRhfuMINvyvPKUQP0Ny65j2nFN2oSsTGHXkMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902861;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtRAPQichhKi1fZ8OzdFVSxK1lYL64dAR8OYMwUFOnM=;
	b=6qMKj825GmC9Iz52D6YkkIcQmINl4Bn4U+tvX0aIQMBiUwMIl13ivYGtacWJ3hnrUAWRqn
	4lBrbga47aL3HQAw==
From: "tip-bot2 for Yu Liao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] printk: Export match_devname_and_update_preferred_console()
Cc: kernel test robot <lkp@intel.com>, Yu Liao <liaoyu15@huawei.com>,
 Petr Mladek <pmladek@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240909075652.747370-1-liaoyu15@huawei.com>
References: <20240909075652.747370-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286143.2215.6212348745263745888.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     3e5b2e81f17f176a4d451c1dd1794e64644319c4
Gitweb:        https://git.kernel.org/tip/3e5b2e81f17f176a4d451c1dd1794e64644319c4
Author:        Yu Liao <liaoyu15@huawei.com>
AuthorDate:    Mon, 09 Sep 2024 15:56:52 +08:00
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Mon, 09 Sep 2024 17:35:06 +02:00

printk: Export match_devname_and_update_preferred_console()

When building serial_base as a module, modpost fails with the following
error message:

  ERROR: modpost: "match_devname_and_update_preferred_console"
  [drivers/tty/serial/serial_base.ko] undefined!

Export the symbol to allow using it from modules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409071312.qlwtTOS1-lkp@intel.com/
Fixes: 12c91cec3155 ("serial: core: Add serial_base_match_and_update_preferred_console()")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Link: https://lore.kernel.org/r/20240909075652.747370-1-liaoyu15@huawei.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c22b070..6ff8d47 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2620,6 +2620,7 @@ int match_devname_and_update_preferred_console(const char *devname,
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(match_devname_and_update_preferred_console);
 
 bool console_suspend_enabled = true;
 EXPORT_SYMBOL(console_suspend_enabled);

