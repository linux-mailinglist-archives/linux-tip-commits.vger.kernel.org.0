Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707A032D50F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbhCDONj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Mar 2021 09:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbhCDONg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Mar 2021 09:13:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869C8C061574;
        Thu,  4 Mar 2021 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y2jvUF+lhqb97tULuXHP14gXTZw21yw05T86t1KT6TM=; b=Awwwy5j0O+Ggcy4S/fl1X+39cz
        tBYus/KTbywzdfAYrmLUSxcSDsQT+rcTkTIxm7wS1e3iH8+LAJQdY8Ny9kheBB4vAIKjMS16twzHs
        LAL4maREcQ64CB8A4cmP6nYUybQN7Mnfdb7cOZ0pPyoceJO880yAz3xslOQStVw/kcwitifK7lNnt
        eq05Q8qD8ua/aypr+CJFF+y11Sbu7N0ohHfpgCYI3xNXKbul6MMWvTQxvQFe34rc+YHlWjOdY+36B
        DAhv3G4l6awaq0BdAvwGnCnr2WG5DkcUIJEq0KewkRTPpwhP0wNh0MsfnUQK0FrmaTyV4nRL4FBPq
        +YgHvPPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHoiM-007Knw-W3; Thu, 04 Mar 2021 14:12:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1E0E306FFE;
        Thu,  4 Mar 2021 15:12:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D16CF2BB8402D; Thu,  4 Mar 2021 15:12:26 +0100 (CET)
Date:   Thu, 4 Mar 2021 15:12:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Parse options from OBJTOOL_ARGS
Message-ID: <YEDqytNoqAMj1M+T@hirez.programming.kicks-ass.net>
References: <20210226110004.252553847@infradead.org>
 <161476113169.20312.14290136035364654285.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161476113169.20312.14290136035364654285.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 03, 2021 at 08:45:31AM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     b52eb21aeca75790869c26b91b1d7b80b3946430
> Gitweb:        https://git.kernel.org/tip/b52eb21aeca75790869c26b91b1d7b80b3946430
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Fri, 26 Feb 2021 11:32:30 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 03 Mar 2021 09:38:32 +01:00
> 
> objtool: Parse options from OBJTOOL_ARGS
> 
> Teach objtool to parse options from the OBJTOOL_ARGS environment
> variable.
> 
> This enables things like:
> 
>   $ OBJTOOL_ARGS="--backup" make O=defconfig-build/ kernel/ponies.o
> 
> to obtain both defconfig-build/kernel/ponies.o{,.orig} and easily
> inspect what objtool actually did.

Latest objdiff.sh to go with this:

$ cat objdiff.sh
#!/bin/bash

name=$1
pre=${name}.orig
post=${name}

function to_text {
	obj=$1
	( objdump -wdr $obj;
	  readelf -W --relocs --symbols $obj |
		  awk '/^Relocation section/ { $6=0 } { print $0 }'
	) > ${obj}.tmp
}

to_text $pre
to_text $post

diff -u ${pre}.tmp ${post}.tmp

rm ${pre}.tmp ${post}.tmp
