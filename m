Return-Path: <linux-tip-commits+bounces-4831-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652EBA84CA4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 21:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722B91BA2FB3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 19:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B728D841;
	Thu, 10 Apr 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVy9BELN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795B28D83E;
	Thu, 10 Apr 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312430; cv=none; b=rmzoI68yd0MDjhK21EMhp8UEwyQZXjo3LpblfuAFHOQ1i4Jm3vlaHmRZWIUx5LSgqWDuQJBmSe5Esq5ECddxDurDFlS+XxIX25WHQzBQKu2fTBiOaMuq41QKLoOyxe1de9aHfBcdptdbMUU9+Ait/EC1hvCJd5mLeFPo2/EKbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312430; c=relaxed/simple;
	bh=CDqDQPLUl5izS3auCwD9l5FEWium8D8RPnEJ3vuRgDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7+bXBluGpWFlgwkz/YIPWZcBdtdvU5YxY6e+BrMwTvzNI5kP6GzggURnOgxmZI8uo54G6O035Jz7ORlyhWl2+4fcpPgvjQqFxLlyzhKDHkS9UVx9nv3jlEjz7dJhy/h7WSNL3LIyHAHMj8Gi5eMLSes1KQ6TluuAeLg/vFwQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVy9BELN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAF3C4CEDD;
	Thu, 10 Apr 2025 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744312430;
	bh=CDqDQPLUl5izS3auCwD9l5FEWium8D8RPnEJ3vuRgDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVy9BELNAhiNn/Oce7YoCROIl+3jfwzVH88gi/KvvLaGqGxISHZL64rNIbF4MR/rs
	 kkERVhxf7jXm2G34dRihTIb64a1VnMr1+4P7+WohGq49aK8DCIpKdcZkv9R9UKTxui
	 AvP+VDQafFOXFGeq2V4FtPE+2Z8UiT/Ppn1GuLHXuoFpc2JuOpZwBMLAMmAamdDHWV
	 ojxelK2mTw8O5vHEe+HyCTj3kMQy9SMDqQDYysP1GYvq6jQsKCGrnYhGNG5bKIMBfD
	 oOxr2lfzyCjGxQXWom/VYRrvHC0ln8wmNPDc6IiKdIv5UwVxWlJhBx4Uq9k2/7W/Sc
	 iSJe2G4jaUrLA==
Date: Thu, 10 Apr 2025 12:13:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/urgent] objtool: Fix false-positive "ignoring
 unreachables" warning
Message-ID: <jd2rsmxvbvawlwwaatx323pzh5on3tjt5cxx5m7icf3sgj6vao@kjmjgb252u3x>
References: <5eb28eeb6a724b7d945a961cfdcf8d41e6edf3dc.1744238814.git.jpoimboe@kernel.org>
 <174426568347.31282.17971680226674649784.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174426568347.31282.17971680226674649784.tip-bot2@tip-bot2>

On Thu, Apr 10, 2025 at 06:14:43AM +0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/urgent branch of tip:
> 
> Commit-ID:     8af6f0fe9c4340ed97f0ba4f3f6cc7bb16558e87
> Gitweb:        https://git.kernel.org/tip/8af6f0fe9c4340ed97f0ba4f3f6cc7bb16558e87
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Wed, 09 Apr 2025 15:49:36 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 10 Apr 2025 08:03:05 +02:00
> 
> objtool: Fix false-positive "ignoring unreachables" warning
> 
> There's no need to try to automatically disable unreachable warnings if
> they've already been manually disabled due to CONFIG_KCOV quirks.
> 
> This avoids a spurious warning with a KCOV kernel:
> 
>   fs/smb/client/cifs_unicode.o: warning: objtool: cifsConvertToUTF16.part.0+0xce5: ignoring unreachables due to jump table quirk
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/5eb28eeb6a724b7d945a961cfdcf8d41e6edf3dc.1744238814.git.jpoimboe@kernel.org
> 
> Closes: https://lore.kernel.org/r/202504090910.QkvTAR36-lkp@intel.com/

Superfluous newline there.

Also, this probably could use a fixes tag:

Fixes: eeff7ac61526 ("objtool: Warn when disabling unreachable warnings")

Thanks!

-- 
Josh

