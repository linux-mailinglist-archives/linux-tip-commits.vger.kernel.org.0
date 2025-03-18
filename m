Return-Path: <linux-tip-commits+bounces-4298-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D1A66354
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 01:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C223B7309
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F04F36C;
	Tue, 18 Mar 2025 00:05:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123D182;
	Tue, 18 Mar 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256325; cv=none; b=Ppveo89kPcyQ61CYtkhzFOvijZGQik9JGJqzXz7ss5UA7NpeNePh7Cf8llgONRRYwLDqkCI1GGvH0YtuhFNCDhv90h4HQQQG03yjNB6PGOhZHygmuV9GbTFv8E0HIddrP6pVVHXb3z0j6YMj1MZJloOoLf5ZhMnB17mSQbvdm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256325; c=relaxed/simple;
	bh=eXnT3yVPlXSFoN5rmhf6g9WZsZkvNCYhA/8jvRz7iu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJMxnJUBEtza56I9EyVvePBJzg7CGJkGjhXSQZA6oPLRrofXL+03WWlZCuxEHDnuqeE0MyFCfcRnFKRtTJd3F7CtH9WVC93PDkz43xXgpEeCkJ5kC2JWI3HeHCQrK1ZORdcUMiGYM7AEw6pbp6jGAJX7uPfH9pkfoR9XbJb6Ahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18879C4CEE3;
	Tue, 18 Mar 2025 00:05:24 +0000 (UTC)
Date: Mon, 17 Mar 2025 17:05:22 -0700
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip: objtool/core] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <rqeb4kmyjdsmkng6aaxcjqkokwlykgunzy35kevpla5hfugglc@rrsjmgex7isg>
References: <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
 <174220964327.14745.17925905226268456380.tip-bot2@tip-bot2>
 <Z9iTsI09AEBlxlHC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9iTsI09AEBlxlHC@gmail.com>

On Mon, Mar 17, 2025 at 10:27:12PM +0100, Ingo Molnar wrote:
> > +config OBJTOOL_WERROR
> > +	bool "Upgrade objtool warnings to errors"
> > +	depends on OBJTOOL && !COMPILE_TEST
> > +	help
> > +	  Fail the build on objtool warnings.
> > +
> > +	  Objtool warnings can indicate kernel instability, including boot
> > +	  failures.  This option is highly recommended.
> > +
> > +	  If unsure, say Y.
> 
> My randconfig build tests found this failure of 36 warnings upgraded to 
> a build failure:
> 
>    vmlinux.o: error: objtool: 36 warning(s) upgraded to errors

Hm, I'm actually surprised randconfig doesn't set COMPILE_TEST.

Anyway, the warnings are valid:

  vmlinux.o: error: objtool: do_syscall_64+0x40: call to ftrace_likely_update() leaves .noinstr.text section
  vmlinux.o: error: objtool: do_int80_emulation+0x30: call to ftrace_likely_update() leaves .noinstr.text section
  vmlinux.o: error: objtool: do_fast_syscall_32+0x7b: call to ftrace_likely_update() leaves .noinstr.text section
  ...

Those are triggered by CONFIG_TRACE_BRANCH_PROFILING which adds a
function call to ftrace_likely_update() for every likely() / unlikely().
Which obliterates the noinstr rules.

Steven, do you still want to keep that config option?

If so, I suppose we could make OBJTOOL_WERROR depend on
!TRACE_BRANCH_PROFILING.

-- 
Josh

