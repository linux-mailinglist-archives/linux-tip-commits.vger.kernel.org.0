Return-Path: <linux-tip-commits+bounces-4412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E667AA6ABB2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 18:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F002D178DEB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8222155C;
	Thu, 20 Mar 2025 17:10:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B75188915;
	Thu, 20 Mar 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490634; cv=none; b=iLGD6FN4e4ASIPIeGbySQYbgO+keQ2SiqG0OZlEh0BxuFwrJcVo0aLpvn4TRc8Q3i8VddOonavdyRydwxLYeXCK/iIokzimtGmM7QsU6qdtiCqowJ7rLPPjgHttw1QrpDb5GIpLlxh4Wbdu8iZnl7TPyMJ9TpaguBftTugAE5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490634; c=relaxed/simple;
	bh=fABS0qDTpLgb5krd8Kmd0/avCrJVBrJSIjq/3yjP1zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8kW4Rr4hPMToTpL/fat4e6s8bS1v2RQqVgQ0fqXZtvVBwe+N2Hz3trF+ynIcPg/8+0TJfRfOnQxdhLyZ7fREibLz+aM1advq5uHzkKWtjk4weVDS8JJSO4HVsCCJTNYsSI5RPqgAAmkcSuK+W9OIWwRFlqV7SPeHQRWopG6C4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7687C4CEDD;
	Thu, 20 Mar 2025 17:10:32 +0000 (UTC)
Date: Thu, 20 Mar 2025 13:10:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <20250320131028.2fea4c73@batman.local.home>
In-Reply-To: <rqeb4kmyjdsmkng6aaxcjqkokwlykgunzy35kevpla5hfugglc@rrsjmgex7isg>
References: <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
	<174220964327.14745.17925905226268456380.tip-bot2@tip-bot2>
	<Z9iTsI09AEBlxlHC@gmail.com>
	<rqeb4kmyjdsmkng6aaxcjqkokwlykgunzy35kevpla5hfugglc@rrsjmgex7isg>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 17:05:22 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:


> Hm, I'm actually surprised randconfig doesn't set COMPILE_TEST.
> 
> Anyway, the warnings are valid:
> 
>   vmlinux.o: error: objtool: do_syscall_64+0x40: call to ftrace_likely_update() leaves .noinstr.text section
>   vmlinux.o: error: objtool: do_int80_emulation+0x30: call to ftrace_likely_update() leaves .noinstr.text section
>   vmlinux.o: error: objtool: do_fast_syscall_32+0x7b: call to ftrace_likely_update() leaves .noinstr.text section
>   ...
> 
> Those are triggered by CONFIG_TRACE_BRANCH_PROFILING which adds a
> function call to ftrace_likely_update() for every likely() / unlikely().
> Which obliterates the noinstr rules.
> 
> Steven, do you still want to keep that config option?

Yes, in fact I just ran it a couple of months ago:

  https://rostedt.org/branches/current/

That's the output of both the likely and unlikely output as well as the
full branch tracer. I do look at this to fix places that are incorrect.

> 
> If so, I suppose we could make OBJTOOL_WERROR depend on
> !TRACE_BRANCH_PROFILING.
> 

That, or you can disable it for files with:

  CFLAGS_<file>.o += -DDISABLE_BRANCH_PROFILING

In the Makefile.

-- Steve

