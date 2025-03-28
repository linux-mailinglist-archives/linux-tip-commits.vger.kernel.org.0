Return-Path: <linux-tip-commits+bounces-4576-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C85BA74BC6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 14:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE705179F37
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A110522F3B1;
	Fri, 28 Mar 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/zdq9HV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A122F39C;
	Fri, 28 Mar 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743169509; cv=none; b=Lf3PvR+1rb9sA/AV+ygS4S2g8tliwWgFCY0g4LM2hhoMfAdltHdDUoRWu59fWp7NK4MZd4ebrFaq6TcGh0DUHERTgH9CPD8QwSiSKI7hsJSu1h8W6KS1PdQHfdwrr488+k8rgAZe30t+pbtjkAPvewDLGW/uRPpafx6r2cc30Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743169509; c=relaxed/simple;
	bh=tKpHLI3sqTeiGvnB5U69bfb2v1lVnDYs4M9qy4VYEos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1LY4TiLxsGrl0jqMPX/G0Gowds7dbNI+/TZMeJfLmBx3z1POLEkQHb+N/NFr1ec7PYvV5Du7DJ9Rwj/uWi2OsnAvgbww7I4Gc9uzPimphBRePdtvY2L4Ac4fvxdG7t/SdSxy+Ds8EAfOwjfk4Frt/h+NqaPXBmuy54VNtHyWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/zdq9HV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C149C4CEE4;
	Fri, 28 Mar 2025 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743169508;
	bh=tKpHLI3sqTeiGvnB5U69bfb2v1lVnDYs4M9qy4VYEos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/zdq9HVdYX0fBnh6GZPVDwX2NZ5Tik4Q7I1O28aFBqDqYvbEMOpml7/lYL/cHl0Z
	 BaX3mdXLqdOKa01w6twdvwPC6y4t8tRoTsynK7TCWktrqNGkhdJKXVnuo/YArJ0BhJ
	 p3AvuYdfNyv1h878jz4qRzYbcdI8hM/SeY8ulxx87iXfmvesGzXj9VgAxn08PDZIBh
	 CWNGzPS0G2V7vQTbecBiMzH07iBEU7V7jkpQ4ZsLWYKd4RNVpSrM+Vmhq9FlZj0KDY
	 DxSU6gubMT7GEnBeKfrEU7jsfGN1TAg+Oz6ZRcIeBLjb0rtK4yN0C2eBR7s+gJMErS
	 gxvu6czcPhw2A==
Date: Fri, 28 Mar 2025 14:45:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-tip-commits@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent
 theoretical divide-by-zero in pwm_mediatek_config()
Message-ID: <Z-an4KuB-OQE5ovv@gmail.com>
References: <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
 <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
 <m7pgkp3ueo7iqgqf74upjrihr3mpmb3sqhwegnjxxwsrgx2jsw@dnec5iqiyobh>
 <Z-Uv60sD_S2xYVB1@gmail.com>
 <nzk5uzpwqqkflmdgfe7kwsnsecqnsn6vsyo4ycoaueasnud6ot@pg6cazrf6zuf>
 <Z-XBb_8f6cItnlZN@gmail.com>
 <ivss2v7kmk6ylcojffyxwucsmfcgbbe3kxiasbe3dqijvooy6m@vpkopftglx3a>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ivss2v7kmk6ylcojffyxwucsmfcgbbe3kxiasbe3dqijvooy6m@vpkopftglx3a>


* Uwe Kleine-König <ukleinek@kernel.org> wrote:

> > failures in a single place to not inconvenience randconfig CI 
> > testing efforts, so in that sense it would be nice to send this via 
> > the objtool/urgent tree, but I'll remove it if you insist.
> 
> I'm still in the process to determine my opinion on that.

Although Josh's fix looks obviously correct to me, I've removed the 
commit from objtool/urgent, because your indecision about it is 
blocking other fixes. Feel free to pick up the fix in your tree.

Thanks,

	Ingo

