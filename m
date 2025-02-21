Return-Path: <linux-tip-commits+bounces-3565-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C936FA3F632
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D133B550A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB620C494;
	Fri, 21 Feb 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G7r2Oatu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UGeWcEYt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C820C497;
	Fri, 21 Feb 2025 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145033; cv=none; b=s6umC01R63L/EBEkAPDQq4GZ7gta4ewn0IsDGh5yMUzVtSTzNZMguz0LJT/+afBAqUYTnoBJ7hkpbl0T6+qdp3uvmKrIQHtO1P7z/qTSyxs/SsloGONy4ugUeeXyKbfI9Pn2FeDumZ8dZZPRxKzWXWFkCw2Z6LmrU7nYhBMNOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145033; c=relaxed/simple;
	bh=AsssmGR06eM54QGqtSmA23KBfwbQ1WU0ckUTDulG4jU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JIi0cOMYYY+iki/68g+yJfhJhu24YdLVj/iXb8e0xtXdeBo9hGEivOp/q4o4W3FgbMhGGbKxlNxKVKC4hKSiwN1wSrxJwwCuSdSt2gbBIDP8dzGJNzn1mYhRX6kv6SimQNsKg9U2deBKxCaVB1iL1gM8B9D1Qv/qFtRcHc/5j9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G7r2Oatu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UGeWcEYt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 13:37:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740145030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSNXLMAHcVBcroKKi/xv+UaHxIrRYB/kEtGtWwlm/Pw=;
	b=G7r2OatuDLc4Kkoiivlshq0k1fCSfr/yBz3gXNDXac84A78D84shAaObhUWCI0GU4CRxSR
	GdIqSxEIFi+fld8leqfg29DVbj1xyKPkJ34Iu5XA9LqRfRq9bV0wz85J27SaMPaYxSy0lm
	IGUj+xNWaH6eeryqzZlEOqI26zQZleIFVmcG64CiZYfZ90crVDM9S31MrjLfsqIVvMwDEK
	+aED0bsxncI2CSv1zOxyO7WC+4h3SdStNJYEw3D6jzxdgKNj6oX0bhzaop3qSom2tAt/YV
	4S9brLur0Cms8ja6UC4RIkCv1Q/fDmB8aZaahdAoPMrdYPEffYM5C0qgJoRS7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740145030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSNXLMAHcVBcroKKi/xv+UaHxIrRYB/kEtGtWwlm/Pw=;
	b=UGeWcEYtASkckjFSu+Fv9HGufBLndB/toXC+aQtRpaugAhvQwKDOsmtGXPBrrc95p+hpDF
	zb4iOD9gj4NDYtCw==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/module: Remove unnecessary check in module_finalize()
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Song Liu <song@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <fcbb2f57-0714-4139-b441-8817365c16a1@stanley.mountain>
References: <fcbb2f57-0714-4139-b441-8817365c16a1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014502999.10177.11219583662056425412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     06dd759b68eea200e488cafbcfd382208a940777
Gitweb:        https://git.kernel.org/tip/06dd759b68eea200e488cafbcfd382208a940777
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Wed, 19 Feb 2025 16:48:49 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 14:27:42 +01:00

x86/module: Remove unnecessary check in module_finalize()

The "calls" pointer can no longer be NULL after the following
commit:

   ab9fea59487d ("x86/alternative: Simplify callthunk patching")

Delete this unnecessary check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/fcbb2f57-0714-4139-b441-8817365c16a1@stanley.mountain
---
 arch/x86/kernel/module.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index cb9d295..615f74c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -278,10 +278,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 	if (calls) {
 		struct callthunk_sites cs = {};
 
-		if (calls) {
-			cs.call_start = (void *)calls->sh_addr;
-			cs.call_end = (void *)calls->sh_addr + calls->sh_size;
-		}
+		cs.call_start = (void *)calls->sh_addr;
+		cs.call_end = (void *)calls->sh_addr + calls->sh_size;
 
 		callthunks_patch_module_calls(&cs, me);
 	}

