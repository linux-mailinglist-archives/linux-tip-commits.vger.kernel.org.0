Return-Path: <linux-tip-commits+bounces-2188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BFF96F71C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852771C24090
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FDF1D1F62;
	Fri,  6 Sep 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eb2E2mb5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VbNgNzmH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A01D04A4;
	Fri,  6 Sep 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633680; cv=none; b=WCVKBje6M23KciG7w8qPEaXwAaeeZwhxi0dh+CdqTV3YaJ8rj7cIyXdE4uruT6yIf5jd23TYYAJZQXndhtaUG/HkLiFnjI6G4qcE0HuFeaF+dSti//uluUGCaIF/2hx5vN+6htFA5dlHTQq4TSfcOxLpvvDGpjuGNrhueZp3Zd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633680; c=relaxed/simple;
	bh=b9Mn8E0+NhSUf0pizjpqAWw9FSt8c02zSvtQ85X7OE4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mQevHb+bxh+O4993PJ6il8BU3FDbXBElcIesi063fjxWCVnKcpQnpjLcQvE73yQ8azM0wags/ooIvJIePeCGEz1+aD2y2QDyGXc6obpBaTvhXKEJOkhg8GsaQH4YUqb0YfbewktdReFEQ8Xb+wniw5hkIvrq/ACWJVkr1DIV4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eb2E2mb5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VbNgNzmH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 14:41:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725633677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZXYmC3m+TW7KLVDEokoNmA/QjvDQj+jio2F24OOYyE=;
	b=Eb2E2mb5gvKytwGJ1UVe53C5oy6bda9z7HtC1JcUDxkZDxvHwLDRwPr4qPjKlrSZJc84hS
	0n2SpgUAWq0R/f7yb/X2JVA2TBbTwsev8KiP6tqFOgFxqy2VOmicdYqVrsbo97eBF4n5am
	NwcLZFzn7OmR0QzIlEMUgfMcWrxru/NnKw7rVxgUEA/cbNrMb4nNuq/wcNEmcOrRPxHnSS
	wY7VRNILdKeBg2SIqHbuIbpB45lBLwvDR/84T08f9wL2tbVnDnO0kLc9ajPW/C7ajjQWoo
	ok7FUQyZzkcxDbeX+6RhfKY9y3jxK8jwOtgkhDRWfqfRYr+m7Z8l89o4C2EFew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725633677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZXYmC3m+TW7KLVDEokoNmA/QjvDQj+jio2F24OOYyE=;
	b=VbNgNzmHBZZYOlZbvfqwAFzWnzpJp8kpwyx0eDUXihc3ImvZObranavcsA/6jRYFQq/VMn
	sIJwfhvNZcNb1jBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Handle module init failure
 correctly in static_call_del_module()
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87zfon6b0s.ffs@tglx>
References: <87zfon6b0s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172563367653.2215.9634013543547038937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4b30051c4864234ec57290c3d142db7c88f10d8a
Gitweb:        https://git.kernel.org/tip/4b30051c4864234ec57290c3d142db7c88f10d8a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 11:09:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Sep 2024 16:29:21 +02:00

static_call: Handle module init failure correctly in static_call_del_module()

Module insertion invokes static_call_add_module() to initialize the static
calls in a module. static_call_add_module() invokes __static_call_init(),
which allocates a struct static_call_mod to either encapsulate the built-in
static call sites of the associated key into it so further modules can be
added or to append the module to the module chain.

If that allocation fails the function returns with an error code and the
module core invokes static_call_del_module() to clean up eventually added
static_call_mod entries.

This works correctly, when all keys used by the module were converted over
to a module chain before the failure. If not then static_call_del_module()
causes a #GP as it blindly assumes that key::mods points to a valid struct
static_call_mod.

The problem is that key::mods is not a individual struct member of struct
static_call_key, it's part of a union to save space:

        union {
                /* bit 0: 0 = mods, 1 = sites */
                unsigned long type;
                struct static_call_mod *mods;
                struct static_call_site *sites;
	};

key::sites is a pointer to the list of built-in usage sites of the static
call. The type of the pointer is differentiated by bit 0. A mods pointer
has the bit clear, the sites pointer has the bit set.

As static_call_del_module() blidly assumes that the pointer is a valid
static_call_mod type, it fails to check for this failure case and
dereferences the pointer to the list of built-in call sites, which is
obviously bogus.

Cure it by checking whether the key has a sites or a mods pointer.

If it's a sites pointer then the key is not to be touched. As the sites are
walked in the same order as in __static_call_init() the site walk can be
terminated because all subsequent sites have not been touched by the init
code due to the error exit.

If it was converted before the allocation fail, then the inner loop which
searches for a module match will find nothing.

A fail in the second allocation in __static_call_init() is harmless and
does not require special treatment. The first allocation succeeded and
converted the key to a module chain. That first entry has mod::mod == NULL
and mod::next == NULL, so the inner loop of static_call_del_module() will
neither find a module match nor a module chain. The next site in the walk
was either already converted, but can't match the module, or it will exit
the outer loop because it has a static_call_site pointer and not a
static_call_mod pointer.

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/87zfon6b0s.ffs@tglx
---
 kernel/static_call_inline.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 639397b..7bb0962 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -411,6 +411,17 @@ static void static_call_del_module(struct module *mod)
 
 	for (site = start; site < stop; site++) {
 		key = static_call_key(site);
+
+		/*
+		 * If the key was not updated due to a memory allocation
+		 * failure in __static_call_init() then treating key::sites
+		 * as key::mods in the code below would cause random memory
+		 * access and #GP. In that case all subsequent sites have
+		 * not been touched either, so stop iterating.
+		 */
+		if (!static_call_key_has_mods(key))
+			break;
+
 		if (key == prev_key)
 			continue;
 

