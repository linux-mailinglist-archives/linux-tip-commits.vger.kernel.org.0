Return-Path: <linux-tip-commits+bounces-5669-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11419ABAE63
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 May 2025 09:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9060189AC59
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 May 2025 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2680D20012C;
	Sun, 18 May 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FktQFRCU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GGHItxZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00881DE4DC;
	Sun, 18 May 2025 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747551622; cv=none; b=ObOxm7I3ju0svJG74MXW2NqhgeolQRsSMrr5WcRor9shg9x90RHLm4ad0+gKEvgm9uYE4DRFSjW6wBc44LoeDS1xWfTpdt/JUDSeo8VXwroRn2HAyHeW0sdq4VKCeRHPGqG5SVop3y+kHJm1Y9DbNTZgi4ex5vKolDM0xhqX2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747551622; c=relaxed/simple;
	bh=O6UOmOMbyMAcPy3sWRjKrwUNLPaldVQJ+NeP0iPbbkk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A0acY7YRfRGAWlbXlYUZew17UpyyMI/lZD0Fmf50VDJmdOwPanVqNJJFUAOG4Oo4uHPMZ+jJULbKjoAIazJP38gh/JvXymtM5BeUHW+7yX84jdHRfnmRguksVEe6mFtrkj8AFiuI4Xcs9oS0Jnh3gbePE4b/oB8bcSKSzbw26qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FktQFRCU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GGHItxZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 May 2025 06:50:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747551040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF2aEwSEKZal86vhpJ4OER2WdcQabGGgx2p8f9SwQgY=;
	b=FktQFRCUwmqHexG1OB3U0Z8DYX7oev2iKCyAqGDZdJb0zarPawJvygrZjCH4pHQI+4jHSp
	PL0zz17jqAkyU84jo4cS4Jn8Ve2nMkTBtV9hDUINDwztwdL/G5Cv2Xb12e4vWLUXaEkBxh
	pBBbGqJfawvGKsbhJm+6jEt5o+WUcuTII6n6oOZnMgo/phkuB6z7ukBdMGTneThg7wyGF5
	LokndO3H3HQkk5tT+vuUFobehL0PWT/e5QDEA35GOjx5RIa0uBL03GQpt4UDYMse4qxZDz
	DLHdZyH8ImGROC2giJWUUqRxawvdUyCb3ymDu1HQPa3JYnLvuU3KNvFS07/ZcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747551040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF2aEwSEKZal86vhpJ4OER2WdcQabGGgx2p8f9SwQgY=;
	b=1GGHItxZr49/EFZQ3axclha6ShBcprsnDnGQIF8oGuElrJuU0x9G0Wnu6u2PGMkwXAf4l9
	Cl4w6L/cghJdF1Bw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/xen/msr: Fix uninitialized variable 'err'
Cc: Dan Carpenter <dan.carpenter@linaro.org>, "Xin Li (Intel)" <xin@zytor.com>,
 Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250517165713.935384-1-xin@zytor.com>
References: <20250517165713.935384-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174755103913.406.1174012885663759138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     54c2c688cd9305bdbab4883b9da6ff63f4deca5d
Gitweb:        https://git.kernel.org/tip/54c2c688cd9305bdbab4883b9da6ff63f4deca5d
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sat, 17 May 2025 09:57:12 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 18 May 2025 08:39:16 +02:00

x86/xen/msr: Fix uninitialized variable 'err'

xen_read_msr_safe() currently passes an uninitialized argument 'err' to
xen_do_read_msr(). But as xen_do_read_msr() may not set the argument,
xen_read_msr_safe() could return err with an unpredictable value.

To ensure correctness, initialize err to 0 (representing success)
in xen_read_msr_safe().

Do the same in xen_read_msr(), even err is not used after being passed
to xen_do_read_msr().

Closes: https://lore.kernel.org/xen-devel/aBxNI_Q0-MhtBSZG@stanley.mountain/
Fixes: d815da84fdd0 ("x86/msr: Change the function type of native_read_msr_safe()"
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250517165713.935384-1-xin@zytor.com
---
 arch/x86/xen/enlighten_pv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 7f9ded1..26bbaf4 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1162,7 +1162,7 @@ static void xen_do_write_msr(u32 msr, u64 val, int *err)
 
 static int xen_read_msr_safe(u32 msr, u64 *val)
 {
-	int err;
+	int err = 0;
 
 	*val = xen_do_read_msr(msr, &err);
 	return err;
@@ -1179,7 +1179,7 @@ static int xen_write_msr_safe(u32 msr, u64 val)
 
 static u64 xen_read_msr(u32 msr)
 {
-	int err;
+	int err = 0;
 
 	return xen_do_read_msr(msr, xen_msr_safe ? &err : NULL);
 }

