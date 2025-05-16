Return-Path: <linux-tip-commits+bounces-5579-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70330AB9EDF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 16:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B71A3B18A2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E719C17A2FA;
	Fri, 16 May 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNF0kcQV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L/5qwxCl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE178F5E;
	Fri, 16 May 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406815; cv=none; b=tOqGjdO1coQDbwmdcL2oedi9lH7vhbBzcpxQ4thLonddH4VPvOmSYg/WxWTiuO46Yd+ulDdcELYLiT6bR9DkoKrctmP1N/mx95sExyjEz/PCEw/YclrS3JIeFQQvqn9FFpZYpKWsVQFkPgMu8mkPisdaNW13vTzRv9uQG0UmE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406815; c=relaxed/simple;
	bh=Kyp6Fcc6ndTs83RZdUFSqeJ1lvhFZT/9qSd08CQk4G8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Yo9pOl2cKjsFxgtEYmSbCWqOwSMGgNR8sxhiM6NyHeN7A99s/56q6xP+NpfLwG6YN/EAvbTIE9zGf09AKydBrGQnUEI9Y1WhjU5ua5BRnYCc9PmXf737HfURaucjD9V2WE+dxArLXrFxhZXbi3UwErPzFKiCwjxLKTuZeg/5Wlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNF0kcQV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L/5qwxCl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 14:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747406805;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nw6Gq099c+xX+chvoJbtymvejdXDDLgljNwvrtCl4pM=;
	b=aNF0kcQVAXDywxN7HckTG6Vd4SgXgO96RBxKjfe5/ChSqum0fCIZ9LFs0JBhIoVnJ2/nqd
	mtx/vs5fCgpvzuAXIx08NQJOIYZKvXCPSmeGPmQcYmobCkOrXRfxdl7Hg4O2QVXEs5ugDE
	cBnDOo1dpZL6TC+eslC+VXcLtK2232QH7mr6Cq+cQHEIxe7Izihc0aEif+WZ7nQ7V82MmL
	1DIgx8I0WZDzugjT9uU503735j71C0P7CgWD9+kZ36lb3HNaSOhUjujUhfmjL1QDgWPT0h
	n5cJmmKv2bslb1J/+YFQuH9gVHu5Z4f7eb2BUccu2sg9IMbSzKlS8pBcAekc4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747406805;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nw6Gq099c+xX+chvoJbtymvejdXDDLgljNwvrtCl4pM=;
	b=L/5qwxClI10xo2C8vSXIPi9BdCoy7WHwj4PAuh9nx8rdHbCz6mBYto3l9wvSxGSXQYFAkt
	91WmBTfqTx3qSrDQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/bugs: Fix indentation due to ITS merge
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174740680468.406.372152086131806707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ff8f7a889abd9741abde6e83d33a3a7d9d6e7d83
Gitweb:        https://git.kernel.org/tip/ff8f7a889abd9741abde6e83d33a3a7d9d6e7d83
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 16 May 2025 16:31:38 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 16:31:38 +02:00

x86/bugs: Fix indentation due to ITS merge

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dd8b50b..d1a03ff 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2975,10 +2975,10 @@ static void __init srso_apply_mitigation(void)
 
 		if (boot_cpu_data.x86 == 0x19) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				set_return_thunk(srso_alias_return_thunk);
+			set_return_thunk(srso_alias_return_thunk);
 		} else {
 			setup_force_cpu_cap(X86_FEATURE_SRSO);
-				set_return_thunk(srso_return_thunk);
+			set_return_thunk(srso_return_thunk);
 		}
 		break;
 	case SRSO_MITIGATION_IBPB:

