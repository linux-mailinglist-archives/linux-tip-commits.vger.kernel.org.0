Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05D015F0EC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Feb 2020 18:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgBNR6M (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 Feb 2020 12:58:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26252 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388594AbgBNR6L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 Feb 2020 12:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581703090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UACjdQjNAv3xbfQac1fzgBHkjusv+pnqBnjrSiF1gFM=;
        b=NqTMs3eVxfGYtDA+LLs+ZA1ER+frVmSrQY4vdEA4pEx5QEVs/JHnfHWhgwtX/Dk/qW6sSd
        8ve6vOEK0ribwTq6ulxoqPoAFXl53M8xjfACqITIa7qEPXCg1SzEG+1t06owgR2f/XdiaR
        MTGs6MMN9QBr4rB3cyCa3oKuf1Cu5Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-xzsdBgemOAGsM2iDbVFUUg-1; Fri, 14 Feb 2020 12:58:03 -0500
X-MC-Unique: xzsdBgemOAGsM2iDbVFUUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4488D800D53;
        Fri, 14 Feb 2020 17:58:01 +0000 (UTC)
Received: from treble (ovpn-121-12.rdu2.redhat.com [10.10.121.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 315429050E;
        Fri, 14 Feb 2020 17:58:00 +0000 (UTC)
Date:   Fri, 14 Feb 2020 11:57:58 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [tip: core/objtool] objtool: Fail the kernel build on fatal
 errors
Message-ID: <20200214175758.s34rdwmwgiq6qwq7@treble>
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
 <158142525822.411.5401976987070210798.tip-bot2@tip-bot2>
 <20200213221100.odwg5gan3dwcpk6g@treble>
 <87sgjeghal.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sgjeghal.fsf@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Feb 14, 2020 at 01:10:26AM +0100, Thomas Gleixner wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> > On Tue, Feb 11, 2020 at 12:47:38PM -0000, tip-bot2 for Josh Poimboeuf wrote:
> >> The following commit has been merged into the core/objtool branch of tip:
> >> 
> >> Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
> >> Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
> >> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
> >> AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
> >> Committer:     Borislav Petkov <bp@suse.de>
> >> CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00
> >> 
> >> objtool: Fail the kernel build on fatal errors
> >> 
> >> When objtool encounters a fatal error, it usually means the binary is
> >> corrupt or otherwise broken in some way.  Up until now, such errors were
> >> just treated as warnings which didn't fail the kernel build.
> >> 
> >> However, objtool is now stable enough that if a fatal error is
> >> discovered, it most likely means something is seriously wrong and it
> >> should fail the kernel build.
> >> 
> >> Note that this doesn't apply to "normal" objtool warnings; only fatal
> >> ones.
> >
> > Clang still has some toolchain issues which need to be sorted out, so
> > upgrading the fatal errors is causing their CI to fail.
> 
> Good. Last time we made it fail they just fixed their stuff.
> 
> > So I think we need to drop this one for now.
> 
> Why? It's our decision to define which level of toolchain brokeness is
> tolerable.
> 
> > Boris, are you able to just drop it or should I send a revert?
> 
> I really want to see a revert which has a proper justification why the
> issues of clang are tolerable along with a clear statement when this
> fatal error will come back. And 'when' means a date, not 'when clang is
> fixed'.

Fair enough.  The root cause was actually a bug in binutils which gets
triggered by a new clang feature.  So instead of reverting the above
patch, I think I've figured out a way to work around the binutils bug,
while also improving objtool at the same time (win-win).

The binutils bug will be fixed in binutils 2.35.

BTW, to be fair, this was less "Clang has issues" and more "Josh is
lazy".  I didn't test the patch with Clang -- I tend to rely on 0-day
bot reports because I don't have the bandwidth to test the
kernel/config/toolchain combinations.  Nick tells me Clang will soon be
integrated with the 0-day bot, which should help prevent this type of
thing in the future.

-- 
Josh

