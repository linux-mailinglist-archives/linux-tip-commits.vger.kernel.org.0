Return-Path: <linux-tip-commits+bounces-7517-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F2BC823BD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 20:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FC144E741A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A2323D7E6;
	Mon, 24 Nov 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="A30Rw3dv"
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20AA23D7D0;
	Mon, 24 Nov 2025 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011122; cv=none; b=RtgOcR84IwmzEpO36QLy1k7L2523GhQ1WEY6IwxgFeLkgrDd17uOhq1MGkqI4ib1R4/QHKOLdZAWgmaXS6KtsY6xA1zEtsa7ImivyPr2E5go9yEl4cT2gLlhRi/KxJAWMwhg4RQknB3aVcjnMWyGwn8av2ceXQycFlX+eckoge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011122; c=relaxed/simple;
	bh=gOVTaS8JTyK4n3oeRUdTXgAefsV+QvY5Nu/BOA/smoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiSZZtuZeCdg6QPGVquuIcvbgZ6vgPO34tz2sEnllkSlGO0SwT57gtDVf/Ufh5HZkq/rCTJhWd4Ctdn97RPyQtmGV9lXQANfM15kHYzx5SLs7241TZTyZoLxoUhW9UgQ7SyJoXOsjDciKvwKhRpwnai5gg1GIks91xKyYVeclmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=A30Rw3dv; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vNbs7-003vuk-0Y; Mon, 24 Nov 2025 20:05:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=MfnMZQ5rHgwbB3XUmBfM2dB31+lbEUsxVjvWsw+DaYE=; b=A30Rw3dvTRW8VLfNBCk+cDkenr
	nA6kNjTDV2dqgxYnBPwp4s0Ek8eSye7D+1+pvR3xIfKqgAyUJ3+VL8UGo95EE8U/UYsxbil3CX03J
	3cg/PodKZpLkSPyCm08EDmyP+tQIzmoGo05QxWJsb7jxr6Zyl/72s/tUsvmsRqbTxQnmsN5dTeJb9
	MNoG5qHcnY2VfneXzeaFRUEwAPMLzFy2kiSF17RXThqZ9FyujUoBXzi8lHhHsJSt18WZ4B7D4YxX5
	sN+h84I0oM7DDS0PaDM40x3bEveQyeyUmzBXBJXtUBFs6fid5dUcG2HW8soyClHt8Dn6atIFgwonM
	zrhaMFkQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vNbs6-0000ND-1Y; Mon, 24 Nov 2025 20:05:10 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vNbry-0095DO-Ii; Mon, 24 Nov 2025 20:05:02 +0100
Date: Mon, 24 Nov 2025 19:05:00 +0000
From: david laight <david.laight@runbox.com>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Function to get the name of a CPU
 feature
Message-ID: <20251124190500.773e7e1d@pumpkin>
In-Reply-To: <a8b6e603-e3c0-4bc3-b36b-29771d30183b@oracle.com>
References: <20251121095340.464045-27-alexandre.chartre@oracle.com>
	<176398104154.498.14035591969424868341.tip-bot2@tip-bot2>
	<20251124115942.GO4067720@noisy.programming.kicks-ass.net>
	<20251124122639.GBaSRO_-G9dUtVHMaY@fat_crate.local>
	<a8b6e603-e3c0-4bc3-b36b-29771d30183b@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 13:40:47 +0100
Alexandre Chartre <alexandre.chartre@oracle.com> wrote:

> On 11/24/25 13:26, Borislav Petkov wrote:
> > On Mon, Nov 24, 2025 at 12:59:42PM +0100, Peter Zijlstra wrote:  
> >> On Mon, Nov 24, 2025 at 10:44:01AM -0000, tip-bot2 for Alexandre Chartre wrote:  
> >>> The following commit has been merged into the objtool/core branch of tip:
> >>>
> >>> Commit-ID:     afff4e5820e9a0d609740a83c366f3f0335db342
> >>> Gitweb:        https://git.kernel.org/tip/afff4e5820e9a0d609740a83c366f3f0335db342
> >>> Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
> >>> AuthorDate:    Fri, 21 Nov 2025 10:53:36 +01:00
> >>> Committer:     Peter Zijlstra <peterz@infradead.org>
> >>> CommitterDate: Mon, 24 Nov 2025 11:35:06 +01:00
> >>>
> >>> objtool: Function to get the name of a CPU feature  
> > 
> > Also, this commit name needs a verb.
> >   
> >> Boris just reported that this doesn't work on mawk, since it uses a GNU
> >> awk extension (3rd argument for match()).
> >>
> >> Could you please look at writing this in strict POSIX awk?  
> > 
> > The fail is:
> > 
> > awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 20: syntax error at or near ,
> > awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 23: syntax error at or near }
> > awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 26: syntax error at or near ,
> > awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 29: syntax error at or near }
> > make[5]: *** [arch/x86/Build:21: /root/kernel/linux/tools/objtool/arch/x86/lib/cpu-feature-names.c] Error 2
> > make[5]: *** Deleting file '/root/kernel/linux/tools/objtool/arch/x86/lib/cpu-feature-names.c'
> > make[4]: *** [/root/kernel/linux/tools/build/Makefile.build:142: arch/x86] Error 2
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [Makefile:104: /root/kernel/linux/tools/objtool/objtool-in.o] Error 2
> > make[2]: *** [Makefile:73: objtool] Error 2
> > make[1]: *** [/root/kernel/linux/Makefile:1449: tools/objtool] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> > 
> > ls -al /usr/bin/awk
> > lrwxrwxrwx 1 root root 21 Feb 19  2021 /usr/bin/awk -> /etc/alternatives/awk
> > ls -al /etc/alternatives/awk
> > lrwxrwxrwx 1 root root 13 Feb 19  2021 /etc/alternatives/awk -> /usr/bin/mawk
> > 
> > That's debian.
> >   
> 
> Ok. I am working on it.

Can't you just use sed ?
There is no read need for the header or final }
Since you need the header file included for the array bounds you might as well use the
names for the array index.
So something like (worked before I retyped it):
	sed -n -E '/^#define (X86_(FEATURE|BUG)_([^	]*)).*/s//  [ \1 ] = "\1",/p'
(That is [^<space><tab>]* in the middle)
The final .* matches the rest of the line, you could add some 'pattern' to further
verify the match.

It should be possible to just put that into the Makefile generating the include
file in the object directory.

Getting the comments would be more 'interesting', the " would need escaping as well.

	David



