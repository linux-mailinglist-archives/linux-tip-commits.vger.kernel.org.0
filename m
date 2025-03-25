Return-Path: <linux-tip-commits+bounces-4470-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D1A6EC1F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3AD1892ABA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77B1EA7FA;
	Tue, 25 Mar 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sxkvwgbn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W1kvFA9L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49792253B5D;
	Tue, 25 Mar 2025 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893539; cv=none; b=jzlzGv9hSVk6h2kPdBvjh3eg9QebRKID6efVbUlaq0xhx+iA1m1Jr/BRgedB/dxy1fSUHYwvToYhiLePXzC+zQDgvlYz/wpmy3UWIJeTK3aqGm3PTeJKlcqZzfPyULCrbTXyU4svhaVhotY2M999qsZ4nMtoEJqb05y/4CuEOg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893539; c=relaxed/simple;
	bh=rnk+YSuwngH7+cC7IKrh+cSisaADDXw2t4GL3paFYJI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZPIUqALlJToBt1RjB0Gqx1X5Rb9BAWOfiD//IK0fMuXwSI3kGCzaGtZjaekTFoVdxaap5UUGmuRum0YcO6CK5RsmJ9RV42lbcOaXrZYfNyRQ4+LqIWflXzrPZqtB7CX8tHJUo1T1zSuM2leLtV/t+ZSySK4x+YTMCK+BF8/sNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sxkvwgbn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W1kvFA9L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQCOMbLuxWzRg2zLNdWUNQ2Ki3QJ8mXq49d8rrtkRyQ=;
	b=sxkvwgbn7CA2TO5VaXW9/Bvbq48TQ0c6Jmq4hHZtIjzywak/WgfH/HCwLwfLssQbOCIEkX
	YFb458wGWmieQITnxWPHpxFSBjyRY5X2d4hLXvGnEArp3DZtYTW/on/R+m/8o2ymAzNebF
	QJNXUaOtRYZ4IPSHoS9H3Q2GYmchzLc3wI6qX02GkiOCZIeAYkkC9tkGSOvdUE8SWmSgXp
	OFiJ6E7vZwvSlaach994FAFBeggd8PfgAl1pbCKqLo8Qiwsh6EzZs315PRbQqtSyU5tdrX
	nhdyBbXhUtB5qcctNW7lUl01qhe6N7sHTp7q/x9Cst7SoWqypaDHm+vgAwImbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQCOMbLuxWzRg2zLNdWUNQ2Ki3QJ8mXq49d8rrtkRyQ=;
	b=W1kvFA9LeabvwVi/Rsx8KqSrIOpdJ+dxNG10GQX2MFm/AFvzJ84yM+3xqzBSwLaa02D2QB
	zLU3+dsvzzLiSqBg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] MAINTAINERS: Include the entire kcpuid/ directory
 under the X86 CPUID DATABASE entry
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-21-darwi@linutronix.de>
References: <20250324142042.29010-21-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289353588.14745.8813687810291885853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0efb4dc3b084579efe7f5f88370b76d4f1c3bcee
Gitweb:        https://git.kernel.org/tip/0efb4dc3b084579efe7f5f88370b76d4f1c3bcee
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:47 +01:00

MAINTAINERS: Include the entire kcpuid/ directory under the X86 CPUID DATABASE entry

kcpuid's CSV file is covered by the "x86 CPUID database" MAINTAINERS
entry.  Recent patches have shown that changes to that file may require
updates to the kcpuid code, so include the whole of tools/x86/kcpuid/
under the same entry.

This also ensures that myself and the x86-cpuid mailing list are CCed on
future kcpuid patches.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-21-darwi@linutronix.de
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b5fa84..47dbac5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25727,7 +25727,7 @@ R:	Ahmed S. Darwish <darwi@linutronix.de>
 L:	x86-cpuid@lists.linux.dev
 S:	Maintained
 W:	https://x86-cpuid.org
-F:	tools/arch/x86/kcpuid/cpuid.csv
+F:	tools/arch/x86/kcpuid/
 
 X86 ENTRY CODE
 M:	Andy Lutomirski <luto@kernel.org>

