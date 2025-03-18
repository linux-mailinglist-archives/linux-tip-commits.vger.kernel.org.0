Return-Path: <linux-tip-commits+bounces-4299-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C75A663A4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 01:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DF83A59C4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 00:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAC7171A7;
	Tue, 18 Mar 2025 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rb1Xz3Fx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628A17E0;
	Tue, 18 Mar 2025 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257655; cv=none; b=B36miH95mEBqzUQXkj5/Zh2NhG7Vr0EiRSmRQBxsE1Uc2uGHnqG+etV5DQAhWTj7I/1/vn3THNyBs2jyhEWRpwyZ5v/DEQP08XQJKBg4TOYJ+52Vfgr5NuWzUOFX/Z2wCcwfv3eRfIcW4fO+PGfqqjofyxM7cfXqMIpQgnk0w7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257655; c=relaxed/simple;
	bh=qGpFbwTuOycLBbZ9aluNUtLt64CC722QujFTUoSZZRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl9mwqNl9dWvpd3OGMbQGa4G1Lz7Erc8O5gbj9iRBn3qvef4vy+c2GtCkvUKGGkvwQZWbLCY+1A7WX7WT+g3urQw9mR944EiP+ASgyHdG45GvjE5AmQy8MsGiExeS8gOODY02yeZNW7z9ewl3LmGyhIopoEW65zX6Gtqmc/IzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rb1Xz3Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD87C4CEE3;
	Tue, 18 Mar 2025 00:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742257654;
	bh=qGpFbwTuOycLBbZ9aluNUtLt64CC722QujFTUoSZZRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rb1Xz3FxHrQx+QuQvmY9858B83he+dnKsNpSTTxt64emrBRwNAUS8xP2EUUACW0xx
	 +xVEYKMHJSiJQiTQwgaRmtIU/9A496mfz5Ik/n9toQUAHnGwr002USJaBTTG9d6GF9
	 D1YbJwwbgQKfWSzW56jl/lL/1C9jTLHeOFpNhpm2DVgS6R6WRe6EhmHFfOnkNNcHMZ
	 itpSmJK+Rshk+Om5wycSahSbaOFcWhBhuo00AzX/YJncJp4KMgu4RJvbR7npaLwXMr
	 QyTbJ90RiL6HIJ+A3lNnmcwTN2iDXQeSct1p5iKJYbiMsdGeXU8VM2duCHzFMNUQ7G
	 uzstpD04S5ljA==
Date: Mon, 17 Mar 2025 17:27:32 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: objtool/core] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <6s6qhiuj4ugebglftopde6xm364cxmcni4pexnnx5kojz5qnss@vprcgqepaict>
References: <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
 <174220964327.14745.17925905226268456380.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174220964327.14745.17925905226268456380.tip-bot2@tip-bot2>

On Mon, Mar 17, 2025 at 11:07:23AM +0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     36799069b48198e5ce92d99310060c4aecb4b3e3
> Gitweb:        https://git.kernel.org/tip/36799069b48198e5ce92d99310060c4aecb4b3e3
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Fri, 14 Mar 2025 12:29:11 -07:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Mon, 17 Mar 2025 11:51:44 +01:00
> 
> objtool: Add CONFIG_OBJTOOL_WERROR
> 
> Objtool warnings can be indicative of crashes, broken live patching, or
> even boot failures.  Ignoring them is not recommended.
> 
> Add CONFIG_OBJTOOL_WERROR to upgrade objtool warnings to errors by
> enabling the objtool --Werror option.  Also set --backtrace to print the
> branches leading up to the warning, which can help considerably when
> debugging certain warnings.
> 
> To avoid breaking bots too badly for now, make it the default for real
> world builds only (!COMPILE_TEST).

This last paragraph is no longer accurate, looks like it was changed to
be off by default.

-- 
Josh

