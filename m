Return-Path: <linux-tip-commits+bounces-4414-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C320A6B542
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 08:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2780D4A1D04
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80D31F03EA;
	Fri, 21 Mar 2025 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2SekQdf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/wQqvcX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7211F03D3;
	Fri, 21 Mar 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542800; cv=none; b=ebzI9ZBQSMWZH/zob4uHKsTHA4I/DB/aMb7y0J6HAxgTUlVMWkEuTaL7o2yQemG7AKqbSHV+mgQLGH9kyIrJNg0yx6OATlb3avPWkqgoYCb2jDwLWEefXzdPxJSSdlrC+GJwqcu0eqG3oGP0IJJSQNETOo1EngnWGgz6/2HHm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542800; c=relaxed/simple;
	bh=M/+eZ5lVO5z4rBDZ8+V56xB92NTtV3vo53oaABvrfKA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JdMgXcz23qerGwRL3m4Fe4X3+0dZoUvnn7m/uNJt78QUeB77XybDt0OXt892HHYGvJfj/BGCp+mqiP5vtgh2bocYcaKBKizDTFAQyLrBT+vP3VYsYCL/PNplxryP1JZem55SmKp6i1/Pi2IG4hck3EaVtzKu89DQqSnPtwUKmpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2SekQdf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/wQqvcX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Mar 2025 07:39:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742542796;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VmBGQjNyvd/nLic8kqXgsMfJob7UrQShSqhL2/poYI=;
	b=N2SekQdfqUxJ4B8ClbMc9ONBo5gkoi7273GEv1EQeSZVL7NdA6xiVhWLRPXkKhXU4aohPn
	d3CQqTfY8XkFO+9TqpA80a41XTx+tc9KZqvnkfEy2JrjVyjrOjl2Su4K4GBbyrrLYE9WYm
	FkIIZ+oglkxGqX5fGmSRw839nLwU/Gn6Z9NMugyVDbXbjesHvYd8cblrKYkduXLbJKvWoO
	lUIbffgNGB5DjOUhhhc7K1ePEV2XxKD/TQq4igGd2Po1Nt+JAO0gNwbcKrCrseFJfQF52V
	/DMKiEJoAb6OYbhLSFHPjO9xDJdj0a9SXdhQVbHOQWjA0kTTlwz/h5WKd3arAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742542796;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VmBGQjNyvd/nLic8kqXgsMfJob7UrQShSqhL2/poYI=;
	b=u/wQqvcXko55u0rBO90xAWYIg/NPZQoO+RyTT9cL9huJ6+szLzyDSD3qFsmaSksDavdbqo
	25AbMNlmKIgOChDA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/asm: Make asm export of __ref_stack_chk_guard
 unconditional
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250320213238.4451-2-ardb@kernel.org>
References: <20250320213238.4451-2-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174254279155.14745.9731038935192070573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3e57612561138d7142721a83743fb8eb2bf09ec5
Gitweb:        https://git.kernel.org/tip/3e57612561138d7142721a83743fb8eb2bf09ec5
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 20 Mar 2025 22:32:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Mar 2025 08:34:28 +01:00

x86/asm: Make asm export of __ref_stack_chk_guard unconditional

Clang does not tolerate the use of non-TLS symbols for the per-CPU stack
protector very well, and to work around this limitation, the symbol
passed via the -mstack-protector-guard-symbol= option is never defined
in C code, but only in the linker script, and it is exported from an
assembly file. This is necessary because Clang will fail to generate the
correct %GS based references in a compilation unit that includes a
non-TLS definition of the guard symbol being used to store the stack
cookie.

This problem is only triggered by symbol definitions, not by
declarations, but nonetheless, the declaration in <asm/asm-prototypes.h>
is conditional on __GENKSYMS__ being #define'd, so that only genksyms
will observe it, but for ordinary compilation, it will be invisible.

This is causing problems with the genksyms alternative gendwarfksyms,
which does not #define __GENKSYMS__, does not observe the symbol
declaration, and therefore lacks the information it needs to version it.
Adding the #define creates problems in other places, so that is not a
straight-forward solution. So take the easy way out, and drop the
conditional on __GENKSYMS__, as this is not really needed to begin with.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250320213238.4451-2-ardb@kernel.org
---
 arch/x86/include/asm/asm-prototypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 8d9e627..11c6fec 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -20,6 +20,6 @@
 extern void cmpxchg8b_emu(void);
 #endif
 
-#if defined(__GENKSYMS__) && defined(CONFIG_STACKPROTECTOR)
+#ifdef CONFIG_STACKPROTECTOR
 extern unsigned long __ref_stack_chk_guard;
 #endif

