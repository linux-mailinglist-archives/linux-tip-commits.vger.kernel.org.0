Return-Path: <linux-tip-commits+bounces-7514-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B75C8073F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 13:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E956E4E0401
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA4E226CFE;
	Mon, 24 Nov 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xvh7IRVr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76291E487;
	Mon, 24 Nov 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987223; cv=none; b=lMXILhaXVm5SOwletycjd3BBRSf4fLlFbEepkXRJugINKazwzJkcpaimegM3pisYl6i7G3Wu8XaIOduW4lSW4qqOAnlUkOCZ3sUbFfd5blnRCltDBp7humH094MKUGCubx2ldFwtZX8/WKuycPh2ntm6vlz7W5iVxXWaBDC/U2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987223; c=relaxed/simple;
	bh=wG89KXMHL5aodrz8a4MP/ffC3lcgoQXkcl9cBwRUp1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow7gyq3Kixtu1HI0IeCTExkJzlg/2LThAfDyfs9wG6L9PXmVKwf0ZjvNdILJlKmh+TC6wF8Sb8vmxZfwdl0h6qAWiH/++7v28jrY/rToQ4gnZ1kJ51+fACmJt7M9rOBzIfKiO0eEUcDiH/8yhAl/1iipOJGOK4L/hskMGVKhsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xvh7IRVr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 77DEC40E0216;
	Mon, 24 Nov 2025 12:26:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IcWpPlOpTdOv; Mon, 24 Nov 2025 12:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763987213; bh=+Z+NeMdx/MAGcW4u+WB3ZIFlmYyzRR9hgxXME2gxmB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xvh7IRVrN768BUb0c4oHl5QoPH0sbEF9+OhrR9S0moW/f+hzAGj9W6Zk2LpdOQ3m+
	 d+mVpoCFbKj+ek3K4dxMD+hFIOhl/ByZ4ldEkGKQ3xAFeTU5m7kaHgtu3ztbrXHzLc
	 2uq8rvGIlyq0lftuzw/ZsIYEo3KOLUZtgUFlVbeFprISgzT+SKNye9SoyI07/mOQUi
	 kQp6tywPQXdTYSSsj+diZAREpsPt3GmlzpCxjypiD8i8RXUy9CrdrkmvU0Joc516gq
	 ObP9a0arWoq0ZxErEPgZ3VSw9LagulsnkXNHcI0WqrVoHTdL/f0T2bsGZJFmWzz0Iq
	 JDd8qksdwfM3nI8SA87Upxy3x9ZIDB11Ed+YGrrTlrwE+PO2+398piEmAYn3yeKGGa
	 0AFRhmJ79kACwCn+W2jehKckTjRVFvynLLtqBgsnsw3pT3CI1RrPo8xsD/9RVyQkHa
	 SdtiFDjVWFyqkjbnCp4+4hU93PMJkkQORA6n3DPmPNdUOGtikNruV5VsKabYDNWB5L
	 BBSq3p1AE1oE1ANEkh95qYAcGDn8YPSPBnSXq2jQ+MSuRTQDvz9T8fluMGpK7R7Pdu
	 DqHgAw8/d07lwUWb2RcFxEz6PwRqyiqDlwjnKF7IolwXAiVPQNVVHjuIi265nhIAco
	 VwOcS6w1Mml77uTzUCMBcQj8=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 126FB40E01A8;
	Mon, 24 Nov 2025 12:26:47 +0000 (UTC)
Date: Mon, 24 Nov 2025 13:26:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Function to get the name of a CPU
 feature
Message-ID: <20251124122639.GBaSRO_-G9dUtVHMaY@fat_crate.local>
References: <20251121095340.464045-27-alexandre.chartre@oracle.com>
 <176398104154.498.14035591969424868341.tip-bot2@tip-bot2>
 <20251124115942.GO4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124115942.GO4067720@noisy.programming.kicks-ass.net>

On Mon, Nov 24, 2025 at 12:59:42PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 24, 2025 at 10:44:01AM -0000, tip-bot2 for Alexandre Chartre wrote:
> > The following commit has been merged into the objtool/core branch of tip:
> > 
> > Commit-ID:     afff4e5820e9a0d609740a83c366f3f0335db342
> > Gitweb:        https://git.kernel.org/tip/afff4e5820e9a0d609740a83c366f3f0335db342
> > Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
> > AuthorDate:    Fri, 21 Nov 2025 10:53:36 +01:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Mon, 24 Nov 2025 11:35:06 +01:00
> > 
> > objtool: Function to get the name of a CPU feature

Also, this commit name needs a verb.

> Boris just reported that this doesn't work on mawk, since it uses a GNU
> awk extension (3rd argument for match()).
> 
> Could you please look at writing this in strict POSIX awk?

The fail is:

awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 20: syntax error at or near ,
awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 23: syntax error at or near }
awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 26: syntax error at or near ,
awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 29: syntax error at or near }
make[5]: *** [arch/x86/Build:21: /root/kernel/linux/tools/objtool/arch/x86/lib/cpu-feature-names.c] Error 2
make[5]: *** Deleting file '/root/kernel/linux/tools/objtool/arch/x86/lib/cpu-feature-names.c'
make[4]: *** [/root/kernel/linux/tools/build/Makefile.build:142: arch/x86] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [Makefile:104: /root/kernel/linux/tools/objtool/objtool-in.o] Error 2
make[2]: *** [Makefile:73: objtool] Error 2
make[1]: *** [/root/kernel/linux/Makefile:1449: tools/objtool] Error 2
make: *** [Makefile:248: __sub-make] Error 2

ls -al /usr/bin/awk 
lrwxrwxrwx 1 root root 21 Feb 19  2021 /usr/bin/awk -> /etc/alternatives/awk
ls -al /etc/alternatives/awk
lrwxrwxrwx 1 root root 13 Feb 19  2021 /etc/alternatives/awk -> /usr/bin/mawk

That's debian.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

