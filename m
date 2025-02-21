Return-Path: <linux-tip-commits+bounces-3582-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99EA3F98B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38A4860497
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD311DC075;
	Fri, 21 Feb 2025 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDZvi+dx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YESa61xw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2911D86E8;
	Fri, 21 Feb 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153024; cv=none; b=tjONyb5KU4IyaNj0mVvcQMcSp2iEs3wbz0GEy1vajs2PCmDWZfsRrhwkkapNyuCK+wafsNbwO4H8xlzeKFh2ODsShP2QsTvQPf3vT1/sfDQ6EojxxTBHqw9pQeIh9PvCjMuyOubXZOheVpwxpdH4rw5lCLrByl8Z7tDeC+RWP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153024; c=relaxed/simple;
	bh=qHKoI2iWkXUXOD6HQ2Lw4pH7NK4TycvVeQmTJo9UWh0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E46juCQjpI/6jIgzzgCRe3omORp71gPbFEcGl4DacwRhW9ZGWOkh7e57RZb0jllPMCe1v9+c/8LTqnX4Do14UoJyez8zR7JOVH0tee0z2JAfkGIvXY0gqYf0/CZaB95MpE++1/nA6Ar1l7ahNjygPBWzQKtgdNAZpDorge1rwHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDZvi+dx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YESa61xw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:50:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740153021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYmKzpxt8jwpq22g91oN4fk/NCnDB2xj+onYBsVn4kY=;
	b=hDZvi+dxoKYVpFOgVvssGnmhKsEs0Egc8yU7n6Nasug+JX1LehXAGtuzTES23p6f6d6eXB
	kKdBvQ8ZXr/AbQVW1WYcKy2aWrlpE0fOV2jDJhhMKtV15hprfrrLhybfky6yjkE9BZ0tOi
	IDJoHnI2zEcb5XMWeYHAcw0LCoKDk0uxvGSAsWJdgSiDFdZ6tnHB53T3o1CAnL3vifOJCZ
	1Nf7c0J4nl1/a3zCRRCTpWE9stuKSybshedpNvoTzWQl8lkW6KeINrGQcp5eeMunfsuXXZ
	qv3lh3npf1hj9+7Am8J1H8YIuHxH1Dba5qEPNdohM3Zifi40FezfmrkZIr1Y7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740153021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYmKzpxt8jwpq22g91oN4fk/NCnDB2xj+onYBsVn4kY=;
	b=YESa61xwR6ZfHQ49IIeD0sLxNloVsl0ejLxQ8L9sQbgt5UklvCqh7proOa2zcpeVJ0zA0/
	9tXRbtpmfReb4mBQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/pat: Fix W=1 build warning when the
 within_inclusive() function is unused
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250211145721.1620552-1-andriy.shevchenko@linux.intel.com>
References: <20250211145721.1620552-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015301916.10177.6568823260233216163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     3fcae7771fb724c276e87e80827b264d2c3ad67e
Gitweb:        https://git.kernel.org/tip/3fcae7771fb724c276e87e80827b264d2c3ad67e
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Tue, 11 Feb 2025 16:57:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 16:35:49 +01:00

x86/pat: Fix W=1 build warning when the within_inclusive() function is unused

The within_inclusive() function, in some cases, when CONFIG_X86_64=n,
may be not used.

This, in particular, prevents kernel builds with Clang, `make W=1`
and CONFIG_WERROR=y:

  arch/x86/mm/pat/set_memory.c:215:1: error: unused function 'within_inclusive' [-Werror,-Wunused-function]

Fix this by guarding the definitions with the respective ifdeffery.

See also:

  6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250211145721.1620552-1-andriy.shevchenko@linux.intel.com
---
 arch/x86/mm/pat/set_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7bd0f62..84d0bca 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -225,14 +225,14 @@ within(unsigned long addr, unsigned long start, unsigned long end)
 	return addr >= start && addr < end;
 }
 
+#ifdef CONFIG_X86_64
+
 static inline int
 within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
 {
 	return addr >= start && addr <= end;
 }
 
-#ifdef CONFIG_X86_64
-
 /*
  * The kernel image is mapped into two places in the virtual address space
  * (addresses without KASLR, of course):

