Return-Path: <linux-tip-commits+bounces-4968-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864EAA8798D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075467A907B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B492580F9;
	Mon, 14 Apr 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="thQiez2c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MnFncKY3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E591A5B82;
	Mon, 14 Apr 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617359; cv=none; b=GTwktXYFyJ/E4DzCkTXg2aYcdsejhzc7fn2SQW3MFWpSFaYTa1gtqYZ3/iTsY9ZlIvMVp+/uplaP7w6rVZ0WfJj9gy+YPbGm07Zg6IU+vuEPdM2BeXNhY9W9omE4SeYld0hg4DxT2YiKnnCyYw46A9Tp2X3/nFKblT05P9CFf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617359; c=relaxed/simple;
	bh=vrsZh3uAG1aDJMEf6ghO31G+kZx2VPa64CHtzE45Utw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tUEf0Q6NhV7GOX/oUBLoPUz6e5AY+LfF4R5zMSP89HUjmXe94fgChbKVAFsQOpAnFsnmykzvFGUgUGkqhnhD48wDi4eNpbSBhqU7heyUHwBnPUj+vCdjLgjGMwRsqwfdeC4ODHplsXF1kp4ORZCdo8KPYOKK5J8qUFB/yE3afps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=thQiez2c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MnFncKY3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 07:55:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744617355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElGkOZjkzLr8xH5zBFdX2kyDZSP44f/fcuLV7YD5vks=;
	b=thQiez2cHEiEvkXpVsww4GK/EF17DiQzMygDlM9vB05sh4NrdKWIIZK0VWmdZwVxdvz2lr
	BluSIbbQBBgVVu8WAHE8jfFhpT6SQCnKIa2ZkNPmPrA+I7OeEpwcNae8tE4xsnvxcbsl6n
	m0thq6aRudGl+wYj6gkXpxgihd/KC0Ob1RZmRhzuGLm000qnqcThI+83zm2BwBUVdnE96X
	bkACdVUW7+jfZwIMpPmNuqJiNshKgav4R5cHYIM3peygeMNkBBW9VnHw2xCABrs6a0Mv4X
	OC9gC4wq7L5NUDkTJrUv0TS2aQYA+UHXKCzVtbuNkdqwt1A9a6DUGMPym8g+Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744617355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElGkOZjkzLr8xH5zBFdX2kyDZSP44f/fcuLV7YD5vks=;
	b=MnFncKY3ne8lTG7rT4Wq8UM6nY0EptNVfwJD7Xi3+q7TlhYDuHGjG6J52yjcZNeMqPnu79
	unGdyA37VTg9h1AA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives, um: Rename UML's
 text_poke_sync() wrapper to smp_text_poke_sync_each_cpu()
Cc: kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <202504141003.kc69fVoj-lkp@intel.com>
References: <202504141003.kc69fVoj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174461735124.31282.10048527543027738159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     f99002b9a9cc441a8f362e6fb32cf8a5a990261a
Gitweb:        https://git.kernel.org/tip/f99002b9a9cc441a8f362e6fb32cf8a5a990261a
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 14 Apr 2025 09:39:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 09:42:22 +02:00

x86/alternatives, um: Rename UML's text_poke_sync() wrapper to smp_text_poke_sync_each_cpu()

Missed this UML wrapper in the rename.

Fixes: 6e4955a9d73e ("x86/alternatives: Rename 'text_poke_sync()' to 'smp_text_poke_sync_each_cpu()'")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/202504141003.kc69fVoj-lkp@intel.com
---
 arch/um/kernel/um_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index d4b3b67..2f5ee04 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -477,7 +477,7 @@ void *text_poke_copy(void *addr, const void *opcode, size_t len)
 	return text_poke(addr, opcode, len);
 }
 
-void text_poke_sync(void)
+void smp_text_poke_sync_each_cpu(void)
 {
 }
 

