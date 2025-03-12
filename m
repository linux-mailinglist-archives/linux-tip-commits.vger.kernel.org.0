Return-Path: <linux-tip-commits+bounces-4135-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DBA5DC1F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 12:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066A31757C1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352122ACD1;
	Wed, 12 Mar 2025 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fwApoWCc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtbLEzwu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442EB235375;
	Wed, 12 Mar 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780763; cv=none; b=Uu5SY1LaUh3zx5NE9sY87CbbuYP/ygYQUqqem7iPc66eVrSpE1RbA8wbxmL1OHy1s7tz66TIeksiEXxx96Z/ZQWRpMTplVd95xoIzQ+94HnFf1/v2dBtRduWDoFTTpc1pYOjpeuOnTFFItM7T8OiIGXYme5heCE0Fg6OlLgWq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780763; c=relaxed/simple;
	bh=pyxS0qKDm/XLUtcB3BwLahufh9XtBnS6Y4mYWkWeM54=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ttc8QwfOhtN8V93UczNrBI+XCIh8uMZ+FiDMkm5XeVIOyJk9xoVcV2TPvq5BS6N+YPIN+GHY1MAP+vJnuZOUr4MAQWmSESCESnl16x6UfFXXIpASxD3Sl6KUlGOjwETlU3hoBv+xsgrYInKzSieB4H78Uk84HwEQSWxifNDA1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fwApoWCc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtbLEzwu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 11:59:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741780760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7q4TsRWn4vTYIPq0RC5CG3NmCoB5GOnKjeOpE2lXz4=;
	b=fwApoWCcMHPH/6mJ4bkGmF6tmcPfi0miMbohYcB2LRFHCiHPyZHNFROv5CdVHXfOI3JMM6
	Np70JhHqfhsKQAkMhDdNJLlT7Sax6um8DKmpla3tBcVKI5MUi5WtGmQDvckV3JyOUhfaX4
	Oq0XXc/rssj3uaK9apGC+s2nM2VW+1qG5Z56Fjn/aFuNUCOIuIaM8AssoVSpxl2JNEmrdp
	768oFHqDQU0TaSqap7KScHwusbJTla7xdja/xqxw35U+njhSh6q41DmVpeopBEvgV6L37j
	DobYnHXzdDKaxQ9YpnarLte1fGrLKu+m1PEGpDyS/7g06OaHCSGA97VNBIy3dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741780760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7q4TsRWn4vTYIPq0RC5CG3NmCoB5GOnKjeOpE2lXz4=;
	b=XtbLEzwu74kObLXKrfORTeCgx4fI2iZ0ADgXUqFxZU1Cub037UxcCNAhclpIcEtzkcbgFG
	FzUD9fQdBB03MSBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/stackprotector/64: Only export
 __ref_stack_chk_guard on CONFIG_SMP
Cc: Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-8-brgerst@gmail.com>
References: <20250123190747.745588-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174178075738.14745.15433710467224904900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     c0560fbaab0dab0afbdb3e339b3cb61ef8d3115e
Gitweb:        https://git.kernel.org/tip/c0560fbaab0dab0afbdb3e339b3cb61ef8d=
3115e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 12 Mar 2025 12:48:49 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 Mar 2025 12:51:35 +01:00

x86/stackprotector/64: Only export __ref_stack_chk_guard on CONFIG_SMP

The __ref_stack_chk_guard symbol doesn't exist on UP:

  <stdin>:4:15: error: =E2=80=98__ref_stack_chk_guard=E2=80=99 undeclared her=
e (not in a function)

Fix the #ifdef around the entry.S export.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250123190747.745588-8-brgerst@gmail.com
---
 arch/x86/entry/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index fe5344a..35a91cf 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -62,6 +62,6 @@ THUNK warn_thunk_thunk, __warn_thunk
  * entirely in the C code, and use an alias emitted by the linker script
  * instead.
  */
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && defined(CONFIG_SMP)
 EXPORT_SYMBOL(__ref_stack_chk_guard);
 #endif

