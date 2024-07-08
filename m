Return-Path: <linux-tip-commits+bounces-1632-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA592A795
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 18:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430A7281C6C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8414148310;
	Mon,  8 Jul 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VMNZywL6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F21420DF;
	Mon,  8 Jul 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457345; cv=none; b=LLD+hkDPkzaE8xqZtacN5SzTeIB2zYAD2Sm/43Wik6YmoB9sFmZbK4+YF2vCxsp9AoSBQ0GeChB8gYgpmHEQBr5tyzl/7V218L0aOH+KubzCwVd17/dbMBafjRtrL7uZ14vVsUUnU5R8FT3HcJEutBMLZ+OkkYWNU9RgPmjcffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457345; c=relaxed/simple;
	bh=dn2Naz7DgHKdIPlqUUXdQML8v/8YmmXJzyHEKsgUUkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw8AuZHf9QjCzvpXc17tFjWhwYVEjPiO5AFDvaOLM0cthMCbA545apz1JFZLWkJkl1NL1Ys/MxDZCKYUusBZArXPT4fT9upSaXSJ58GY+1HGFf1Rcm17RDIWsENCEB8uCsthWDz9n7tuGDVnfSY7RIwXr/7ae3NuqhoUa8J/1zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VMNZywL6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8875540E019D;
	Mon,  8 Jul 2024 16:49:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QCR0pN8wUZMS; Mon,  8 Jul 2024 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720457338; bh=4SpgDKEgGt9WxI4KKGDZv5tcCTEy2R9UvSKhwxPW1Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMNZywL6m9FSPyMeeByybJqpDsMCXpjX5av9p8sr2TjwNHDV1dv3LQyEUSvMrJoQq
	 hF8YkjB0AfXMCPjEfF8tTPZygKs6QdnRfwgqHleqTUmON5B1HN2etgcPUHYBKgCmma
	 k5054tLqmNq6IYlYnS9odXv+jbaIPBV7/tO8SOSLvO211zv0EWGGc7F8LrIj5Y663I
	 mlsSrvfVUsDy2C5IjdoAgxdQs2Lsw5cIrqUDLS9KoxOIbhNV87Q0DJsVFnzycAvHMZ
	 AzXhhaJ2QEAqJlunfOIa3Fu5rOEU35t01E6rgOtqE6toQpu7iXuj//fmmN7QRlhJdk
	 vbrNiug8rVgBKaeQvW6G0cWHS4BA893t8d1RELv6QUKG2qlkT54W3jia8HeFXNWd5p
	 BmskGSrhqb87veKMUFOxk1nxasS/Ns1+ZJtsh8o/kUmI4WGPvpwy54FdnWLRqfu7T8
	 +eUvKs7ABnfvL3VOXDhaAySBuZEhr/CC6+R+dpXHdyGJgZJbPFuTcm9hVNUKD3qPD6
	 hrlHIoogIbHRqgJyZ01w0WwGQUl1l3+6zN5jBYH4C5wvcJsCZRQ3Ld5J5PTaDeyBUc
	 +1TsRXh06/8RsqhCLJvt29q5blOU+B3sN4osw33IDB3Qdby1YBnLDAjTCR/C2CztB3
	 umocZt5irpesD90/uHlRJ1Z4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE9B840E0177;
	Mon,  8 Jul 2024 16:48:51 +0000 (UTC)
Date: Mon, 8 Jul 2024 18:48:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool/x86: objtool can confuse memory and
 stack access
Message-ID: <20240708164846.GFZowYbmQpBu2Y4GeL@fat_crate.local>
References: <20240620144747.2524805-1-alexandre.chartre@oracle.com>
 <172043936454.2215.16620277258416300859.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <172043936454.2215.16620277258416300859.tip-bot2@tip-bot2>

On Mon, Jul 08, 2024 at 11:49:24AM -0000, tip-bot2 for Alexandre Chartre wrote:
>  4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12

Right, this is missing a "ff" which is the 4th byte of a disp32.

I.e., ModRM=0, SIB=5 simply means that what follows is a disp32 field:

 REX:                   0x4c { 4 [w]: 1 [r]: 1 [x]: 0 [b]: 0 }
Opcode:                 0x8b
ModRM:                  0x24  [mod:0b][.R:1b,reg:1100b][.B:0b,r/m:100b]
                        register-indirect mode, offset 0
SIB:                    0x25 [.B:0b,base:101b][.X:0b,idx:100b][scale: 0]

 MOV Gv,Ev; MOV reg{16,32,64} reg/mem{16,32,64}
               0:       4c 8b 24 25 e0 ff ff    mov 0xffffffffffffffe0,%r12
               7:       ff
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

