Return-Path: <linux-tip-commits+bounces-3392-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB98A39623
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882177A2309
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F71DD886;
	Tue, 18 Feb 2025 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZ83Yc9T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yd9nIfND"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77E1EB1A6;
	Tue, 18 Feb 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868819; cv=none; b=R7yli88lWTmALElOyHgVf3X5KZdZKgse6NkMjuRE11i9VMnDCRVWXYPhJwcSP/YutAALA4FuTTmGINxC3dERw6RQQYX8jyvNvHBK7hBj/Jg7f9uAUQTR1pQjYRog0gNLh53Q6jerg4lh15C6SpLrAb6reN1ymGnYSIE5Ybyo37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868819; c=relaxed/simple;
	bh=jHuZSEXkByrxDQMLWxi+Z/gyNlt//4+Xh1pbEq+CAyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PB3oVcoEIN0Fz82gd9nNblxyqoeRPn98VOlQTenIdgIWtxgp5F2KZE8Omb9kgGn79LGwig3GnFv9jXlYT+++33Nw7G6ISlLvzC25rQ+sRc40KhKzyRoVL7WUlXzPBqte+kbmXx1y6ASnQDvAfsSk+tATyPc7E551tkzNHeuzQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZ83Yc9T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yd9nIfND; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 08:53:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739868815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bt/S+HlOmzStPkSDFNfUOAlhUFeVs36yQThV+w/DFHk=;
	b=NZ83Yc9TColyy/7jy7I17AmeH7qPogahO7IpuqhtN3qN2HiF41PTLO7pm7tcaD2H320Do7
	Et3upXr9CX/bUn/cMdR84Qz2HRj9p9frVKQqNFOoCxE4tv8unp4asdxViyw5g5i6tEe3B4
	Q++Df2ha5RTkZFMfBJ5xT58DbnNi22sKR8MthEHDJcBS7PtZ6XCjcyBZIWe5dM8mv3WVjN
	5kuR/xkVOvTwDeV901Tltm0TJcXL0FrEnYxu6IeaepMOepLF02w1rIp6fCJoQ32Jq3tHuC
	gqBnVX3eSDSxEolUq7nPcHopGFLQZGnjS0fQzYPgNKtHfeGFSsEBTV3S9DWoFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739868815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bt/S+HlOmzStPkSDFNfUOAlhUFeVs36yQThV+w/DFHk=;
	b=Yd9nIfNDpQ4GH00ObJ238di1t2AQfhPcoThx7Oga2+DhfklD2SskDodjRlminN7aZH48av
	gBWKX0FDMcL5CpDA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] uprobes: Don't use %pK through printk
Cc: thomas.weissschuh@linutronix.de, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250217-restricted-pointers-uprobes-v1-1-e8cbe5bb22a7@linutronix.de>
References:
 <20250217-restricted-pointers-uprobes-v1-1-e8cbe5bb22a7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986881323.10177.14426538506752641637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ec5fd50aeff9c9156304853c6d75eda852d4a2c8
Gitweb:        https://git.kernel.org/tip/ec5fd50aeff9c9156304853c6d75eda852d=
4a2c8
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Mon, 17 Feb 2025 08:43:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 09:48:02 +01:00

uprobes: Don't use %pK through printk

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

For more background, see:

  https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c70704=
68023@linutronix.de/

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250217-restricted-pointers-uprobes-v1-1-e8c=
be5bb22a7@linutronix.de
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ca797c..bf2a87a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -417,7 +417,7 @@ static void update_ref_ctr_warn(struct uprobe *uprobe,
 				struct mm_struct *mm, short d)
 {
 	pr_warn("ref_ctr %s failed for inode: 0x%lx offset: "
-		"0x%llx ref_ctr_offset: 0x%llx of mm: 0x%pK\n",
+		"0x%llx ref_ctr_offset: 0x%llx of mm: 0x%p\n",
 		d > 0 ? "increment" : "decrement", uprobe->inode->i_ino,
 		(unsigned long long) uprobe->offset,
 		(unsigned long long) uprobe->ref_ctr_offset, mm);

