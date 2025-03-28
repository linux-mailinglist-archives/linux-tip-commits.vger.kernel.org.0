Return-Path: <linux-tip-commits+bounces-4579-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102ABA74C05
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989BB3A4AED
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917D35976;
	Fri, 28 Mar 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TdIbR+pj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8cHNaUl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3A10E4;
	Fri, 28 Mar 2025 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170390; cv=none; b=o/0X9rhNXTZ6xghbCQEvfH8oej6+OBgAYOgrealSWjWo0ahLwVsVbQ0J2VpQmR0dy3ZrrB+LUuXUw6oz7KLkgyX34ZuV0BEvKTVKtRn6u1rRAaOEbOQETFq6y8N4+H0VpCJBRibRsFsfev+GdQ/1nuG6GeHaI+UnBtl2rc96AmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170390; c=relaxed/simple;
	bh=FO4cqgU9P1GzUcSC3wZJac25HxaVYyrfUKFvWGhYOpE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WuoQ/C3DPtsqd0rnBMDm9UTxSn2TUUqdHqMN0CtYrMfxNu/AOP2McqxHpuB6hs9UGmBahtcGy8EZXEe9LvqgLfHZIj+yp+UlIiGIQKMSx+DQp0DBehlMH71t9XMx0uRNVS9QfjBT9oKGRj7ZyTCyY7qVO55L2tsLsKl7paDFTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TdIbR+pj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8cHNaUl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Mar 2025 13:59:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743170387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfBD+7mVKJgVCXMeYI6S1imvHBgeXZg00u7bGXtg6HM=;
	b=TdIbR+pj8+SJAV10DvEaemJfHtGHxG+0zfrQGPmkhcp9Ybaqp9+B0LcHsBSDlo4Z5D443p
	ZoZvhe0PFeJFNLnGnQVRID3nEIRWTaTHS/kHu83ebkhhdPXbnlFSlx80fHWu7Gkb5vvhkm
	wpS7Y2beLdbRjHDPMRQ6mdw4wnWL02gxXHw4z09J+ZmsGuID0CklLlrEZIl7rkx4OOptpf
	FNJ7uVyt+8fKTOV0iMWCeqUsmRQRr6TzZsyZ1TmrPRCw/A7Ivvq1kMmDRUfBFRJk1FNknO
	vZOl299R1xWPa2Ccxu8mXRDrm5dfaewLhp20ZWR5EDeH96s0Qrz2EEeb8toUgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743170387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfBD+7mVKJgVCXMeYI6S1imvHBgeXZg00u7bGXtg6HM=;
	b=s8cHNaUl0zzlGmDT94z6BtrcW1QhW08joU4A2k6YHgob7v/82UF0wY/VSmindrf0lWsm4X
	lrTpINLzPRTtVSBw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, drm/vmwgfx: Don't ignore
 vmw_send_msg() for ORC
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <eff3102a7eeb77b4420fcb5e9d9cd9dd81d4514a.1743136205.git.jpoimboe@kernel.org>
References:
 <eff3102a7eeb77b4420fcb5e9d9cd9dd81d4514a.1743136205.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174317038385.14745.7968533827418719644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     ae958b12940bcd4ffa32c44684e4f2878bc5e140
Gitweb:        https://git.kernel.org/tip/ae958b12940bcd4ffa32c44684e4f2878bc5e140
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 27 Mar 2025 22:04:23 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Mar 2025 14:47:02 +01:00

objtool, drm/vmwgfx: Don't ignore vmw_send_msg() for ORC

The following commit:

  0b0d81e3b733 ("objtool, drm/vmwgfx: Fix "duplicate frame pointer save" warning")

... marked vmw_send_msg() STACK_FRAME_NON_STANDARD because it uses RBP
in a non-standard way which violates frame pointer convention.

That issue only affects the frame pointer unwinder.  Remove the
annotation for ORC.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/eff3102a7eeb77b4420fcb5e9d9cd9dd81d4514a.1743136205.git.jpoimboe@kernel.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 1f15990..1d9a42c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -289,7 +289,7 @@ static int vmw_send_msg(struct rpc_channel *channel, const char *msg)
 
 	return -EINVAL;
 }
-STACK_FRAME_NON_STANDARD(vmw_send_msg);
+STACK_FRAME_NON_STANDARD_FP(vmw_send_msg);
 
 
 /**

