Return-Path: <linux-tip-commits+bounces-5883-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3664AE61F1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B705718815BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2391280024;
	Tue, 24 Jun 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1BGXVxpb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QSO0o6je"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A31ACEDA;
	Tue, 24 Jun 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760139; cv=none; b=qfPkBkJPZAb/Dgtinq3q6lq0m6uB+dW8VcexD14qQZpyRz7YTRKjIzmXCj0B+dvfNHbov7IoYkxzFcHrCaPGvjIEMyoRd9ereBoJLiTO+2VyWCx2CxS9U+DZmPgf8zBeiLJ02eG9ZoK6mmUQf8ydZGDf1j9D4IS7dIirmJAt4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760139; c=relaxed/simple;
	bh=GX1baRukY9ukrtrvbCn9jnEKAwjX/+UTl+m7IVld1ms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TTOBi2SMuDxX6GTuVVv0/pvymtcDciUuqJAwj34EtbwOqtIROik0uD9AH5pDxWvAqnTQEWh6DqhZ0Ph6aoFisjnTyFXj1snrxQMSD+gIVrXe+lgngN9ObLpb9xq0QUtpmfZNFRHn7rWi5nHjxejV+/lbAthLDgNYnW5feC3888w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1BGXVxpb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QSO0o6je; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 10:05:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750760135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVtSoIKu9oapSR4Tk0V1YYtAPYigccWggDa2up6zp3U=;
	b=1BGXVxpbhiZGyBRbeOH7O7VLzi8hRPG/YV2WFFj2hulOypSMqFkwNxSYaQdgUqXyeIcF1T
	5en6tlsz1Asqw3irMJVnVU+S0bgSQ0RPVIOP98djszfaYSyQM0nLK1MOU3DuaL3StSuhIY
	tob1+cNAJEQIP3OXNw9CXEO46BclQrCL2QslWJMn/sSbCguSvuKNZp5O1ssWThvARZGmA0
	rqxPLtA5AcwxykuKsb5rpDUqTwzTIzqMpe22bzXez6s3mHAKRkLZ+zHKhsK5AsiLnx8ZCJ
	KaBK18mQGMxsCHfHEFy16X9V2Xouj8ZnMUvQCV2TeaG4Vcs7+I+En9OBMxVzTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750760135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVtSoIKu9oapSR4Tk0V1YYtAPYigccWggDa2up6zp3U=;
	b=QSO0o6jeEaAcGjBV5TqJil60Hz3j5pBP9w4vv1sW0AUAkxe+Q1O5b4TNuA5fgF0VSr3jk2
	a/UXvNlhC1bNWXDA==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Avoid warning when overriding return thunk
Cc: Borislav Petkov <bp@alien8.de>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-eibrs-fix-v4-3-5ff86cac6c61@linux.intel.com>
References: <20250611-eibrs-fix-v4-3-5ff86cac6c61@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175075954857.406.17152971756037290596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     9f85fdb9fc5a1bd308a10a0a7d7e34f2712ba58b
Gitweb:        https://git.kernel.org/tip/9f85fdb9fc5a1bd308a10a0a7d7e34f2712ba58b
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Jun 2025 10:29:31 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jun 2025 12:21:30 +02:00

x86/bugs: Avoid warning when overriding return thunk

The purpose of the warning is to prevent an unexpected change to the return
thunk mitigation. However, there are legitimate cases where the return
thunk is intentionally set more than once. For example, ITS and SRSO both
can set the return thunk after retbleed has set it. In both the cases
retbleed is still mitigated.

Replace the warning with an info about the active return thunk.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250611-eibrs-fix-v4-3-5ff86cac6c61@linux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 94d0de3..20696ab 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -113,10 +113,9 @@ void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
 
 static void __init set_return_thunk(void *thunk)
 {
-	if (x86_return_thunk != __x86_return_thunk)
-		pr_warn("x86/bugs: return thunk changed\n");
-
 	x86_return_thunk = thunk;
+
+	pr_info("active return thunk: %ps\n", thunk);
 }
 
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */

