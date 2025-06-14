Return-Path: <linux-tip-commits+bounces-5846-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E9AD9A92
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Jun 2025 08:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751341897200
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Jun 2025 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C197A1DF97F;
	Sat, 14 Jun 2025 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp++tKyQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E91C3F02;
	Sat, 14 Jun 2025 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749884375; cv=none; b=HXl3d1Y7QHme157A4kNcmnN0Wt8dBm2HPf7wk5BPzVgaU8inbRnl/mqQXhoq0lSeyPqGQ8TvfApeskljXJLd2N6eZQfEcYLsIrtKvdeUrx6S8R4mU0QALfCHE7mmRDG78TTjKrTe6sHoBKaMG2p0nNUFrGsAlyMgHK927gor3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749884375; c=relaxed/simple;
	bh=+GqlhQ0m4QFxvYQvMuMJs0KFzihRO4TErtoa/lVJX1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZzGcDddVYNqoWmhzHXbbq/npxFbkp3Oc9dwzkTFsXij7MIgULnlj+oF4fmKWmgWyAaFaouXHa6NmnZWUZWPtrDVhCKqEDgXD+8Fi5HyokcyoySMJJgLMy2rGC8B/6Lnp72N9rmiZARFx6sSA4/lQJL33+taR7+4Dsi3q/AJoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp++tKyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031E6C4CEEB;
	Sat, 14 Jun 2025 06:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749884375;
	bh=+GqlhQ0m4QFxvYQvMuMJs0KFzihRO4TErtoa/lVJX1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yp++tKyQIL+vWjuuTmGsjDcILwec+i5d7m+67Tnaihi63ASTSkv4zWCfyzqSu7tXp
	 6nxWU/6yAgF4Gc6Vexs6H+ibkJwc9Lz+mbVpqzvCC0QcFpnjrWjPhDEwrTF+ZasQyB
	 GCC2/UBlNrKBj9XxehRJxTURzYEC0d0ErCs147zlIJl+nbDTsAILkbnR1OfndFtRHL
	 h6aWHx41rlaXD3BBbUbtRiw0p84r2mQxnXdku0Mlnu9r8wG6in6XdQwvqHzWPL6fGj
	 dZjNXLAyluxDiEpH0S7NldIiljI/pXq2uR1xPzIGRE9tVu/lhGOAvTAaC9WhKL7Xxn
	 FrKKlIb3vj2mg==
Date: Sat, 14 Jun 2025 08:59:30 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	x86@kernel.org
Subject: [PATCH] syscall_user_dispatch: Fix grammar in
 task_set_syscall_user_dispatch()
Message-ID: <aE0d0uuAxaeCE-9l@gmail.com>
References: <97947cc8e205ff49675826d7b0327ef2e2c66eea.1747839857.git.dvyukov@google.com>
 <174983307181.406.10132559995641241207.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174983307181.406.10132559995641241207.tip-bot2@tip-bot2>


* tip-bot2 for Dmitry Vyukov <tip-bot2@linutronix.de> wrote:

> +	/*
> +	 * access_ok() will clear memory tags for tagged addresses
> +	 * if current has memory tagging enabled.
> +	 *
> +	 * To enable a tracer to set a tracees selector the
> +	 * selector address must be untagged for access_ok(),
> +	 * otherwise an untagged tracer will always fail to set a
> +	 * tagged tracees selector.
> +	 */

Typo/grammar fixes below. (And feel free to squash this fixlet into the 
originator commit.)

Thanks,

	Ingo

==================================>

Signed-off-by: Ingo Molnar <mingo@kernel.org>

 kernel/entry/syscall_user_dispatch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index a9055eccb27e..d5363bc768fe 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -106,10 +106,10 @@ static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned lon
 	 * access_ok() will clear memory tags for tagged addresses
 	 * if current has memory tagging enabled.
 	 *
-	 * To enable a tracer to set a tracees selector the
+	 * To enable a tracer to set a tracee's selector, the
 	 * selector address must be untagged for access_ok(),
 	 * otherwise an untagged tracer will always fail to set a
-	 * tagged tracees selector.
+	 * tagged tracee's selector.
 	 */
 	if (mode != PR_SYS_DISPATCH_OFF && selector &&
 		!access_ok(untagged_addr(selector), sizeof(*selector)))

